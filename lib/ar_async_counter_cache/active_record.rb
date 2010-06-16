module ArAsyncCounterCache

  module ActiveRecord

    def async_increment_counters
      raise %{
        Since you don't have resque installed, please define #{self.class.to_s}#async_increment_counters.
        Basically it should queue a job that calls #{self.class.to_s}#update_async_counters(:increment).
      }.gsub(/\s+/, ' ').strip
    end

    def update_async_counters(dir, *parent_types)
      (parent_types.empty? ? self.class.async_counter_types.keys : parent_types).each do |parent_type|
        if (col = self.class.async_counter_types[parent_type]) && (parent = send(parent_type))
          parent.class.send("#{dir}_counter", col, parent.id)
        end
      end
    end

    module ClassMethods

      def belongs_to(association_id, options={})
        if col = async_counter_cache_column(options.delete(:async_counter_cache))
          # Add callbacks only once: update_async_counters updates all the
          # model's belongs_to counter caches; we do this because there's no
          # need to add excessive messages on the async queue.
          add_callbacks if self.async_counter_types.empty?
          # Store async counter so that update_async_counters knows which
          # counters to update.
          self.async_counter_types[association_id] = col
          # Let's make the column read-only like the normal belongs_to
          # counter_cache.
          parrent_class = association_id.to_s.classify.constantize
          parrent_class.send(:attr_readonly, col.to_sym) if defined?(parrent_class) && parrent_class.respond_to?(:attr_readonly)
          raise "Please don't use both async_counter_cache and counter_cache." if options[:counter_cache]
        end
        super(association_id, options)
      end

      def async_counter_types
        @async_counter_types ||= {}
      end

      private

      def add_callbacks
        # Define after_create callback method.
        method_name = "belongs_to_async_counter_cache_after_create".to_sym
        if defined?(ArAsyncCounterCache::IncrementCountersJob)
          define_method(method_name) do
            Resque.enqueue(ArAsyncCounterCache::IncrementCountersJob, self.class.to_s, self.id)
          end
        else
          define_method(method_name) do
            self.async_increment_counters
          end
        end
        after_create(method_name)
        # Define before_destroy callback method.
        method_name = "belongs_to_async_counter_cache_before_destroy".to_sym
        define_method(method_name) do
          update_async_counters(:decrement)
        end
        before_destroy(method_name)
      end

      def async_counter_cache_column(opt)
        opt === true ? "#{self.table_name}_count" : opt
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end
