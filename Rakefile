begin
  require "jeweler"
  Jeweler::GemcutterTasks.new
  Jeweler::Tasks.new do |gemspec|
    gemspec.name        = "ar-async-counter-cache"
    gemspec.summary     = "Increment ActiveRecord's counter cache column asynchronously (using Resque)."
    gemspec.description = "Increment ActiveRecord's counter cache column asynchronously (using Resque)."
    gemspec.email       = "aaron.gibralter@gmail.com"
    gemspec.homepage    = "http://github.com/agibralter/ar-async-counter-cache"
    gemspec.authors     = ["Aaron Gibralter"]
    gemspec.add_dependency("activerecord", ">= 2.3.5")
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
