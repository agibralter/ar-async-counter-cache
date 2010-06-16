begin
  require 'resque'
  require 'ar_async_counter_cache/resque_job'
rescue LoadError
end

require 'active_record'
require 'ar_async_counter_cache/active_record'

ActiveRecord::Base.send(:include, ArAsyncCounterCache::ActiveRecord)
