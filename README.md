ar-async-counter-cache
----------------------

This gem allows you to update ActiveRecord counter cache columns
asynchronously using Resque (http://github.com/defunkt/resque). You may want
to do this in situations where you want really speedy inserts and have models
that "belong_to" many different parents and also allows for fast inserts of
many children for the same parent.

For example, let's say a single Post gets 1000 comments very quickly. This
will set a key in Redis indicating that there is a delta of +1000 for that
Post's comments_count column. It will also queue 1000 Resque jobs. This is
where resque-lock-timeout comes in. Only one of those jobs will be allowed to
run at a time. Once a job acquires the lock it removes all other instances of
that job from the queue (see IncrementCountersWorker.around_perform_lock1).

You use it like such:

    class User < ActiveRecord::Base
      has_many :comments
      has_many :posts
    end
    
    class Post < ActiveRecord::Base
      belongs_to :user, :async_counter_cache => true
      has_many :comments
    end
    
    class Comment < ActiveRecord::Base
      belongs_to :user, :async_counter_cache => true
      belongs_to :post, :async_counter_cache => "count_of_comments"
    end

Notice, you may specify the name of the counter cache column just as you can
with the normal belongs_to `:counter_cache` option. You also may not use both
the `:async_counter_cache` and `:counter_cache` options in the same belongs_to
call.

All you should need to do is require this gem in your project that uses
ActiveRecord and you should be good to go;

e.g. In your Gemfile:

    gem 'ar-async-counter-cache', '0.1.0'

and then in RAILS_ROOT/config/environment.rb somewhere:

    require 'ar-async-counter-cache'

By default, the Resque job is placed on the `:counter_caches` queue:

    @queue = :counter_caches

However, you can change this:

in RAILS_ROOT/config/environment.rb somewhere:

    ArAsyncCounterCache.resque_job_queue = :low_priority

`ArAsyncCounterCache::IncrementCountersWorker.cache_and_enqueue` can also be
used to increment/decrement arbitrary counter cache columns (outside of
belongs_to associations):

    ArAsyncCounterCache::IncrementCountersWorker.cache_and_enqueue(klass, id, column, direction)

Where:

 * `klass` is the Class of the ActiveRecord object
 * `id` is the id of the object
 * `column` is the counter cache column
 * `direction` is either `:increment` or `:decrement`
