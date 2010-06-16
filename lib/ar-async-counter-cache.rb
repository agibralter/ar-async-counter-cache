require 'active_record'

begin
  require 'resque'
  require 'ar_async_counter_cache/increment_counters_job'
rescue LoadError
end

require 'ar_async_counter_cache/active_record'

ActiveRecord::Base.send(:include, ArAsyncCounterCache::ActiveRecord)
