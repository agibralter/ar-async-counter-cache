module ArAsyncCounterCache

  def self.resque_job_queue=(sym)
    ArAsyncCounterCache::UpdateCountersJob.class_eval do
      @queue = sym
    end
  end

  class UpdateCountersJob
    @queue = :default

    # Take advantage of resque-retry if possible.
    begin
      require 'resque-retry'
      extend Resque::Plugins::ExponentialBackoff
      @retry_exceptions = [ActiveRecord::RecordNotFound]
      @backoff_strategy = [0, 10, 100]
    rescue LoadError
    end

    def self.perform(klass_name, id, dir)
      Object.const_get(klass_name).find(id).update_async_counters(dir)
    end
  end
end
