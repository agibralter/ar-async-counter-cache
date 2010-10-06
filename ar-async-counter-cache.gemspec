# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ar-async-counter-cache}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aaron Gibralter"]
  s.date = %q{2010-10-06}
  s.description = %q{Increment ActiveRecord's counter cache column asynchronously using Resque (and resque-lock-timeout).}
  s.email = %q{aaron.gibralter@gmail.com}
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    ".gitignore",
     "README.md",
     "Rakefile",
     "VERSION",
     "ar-async-counter-cache.gemspec",
     "lib/ar-async-counter-cache.rb",
     "lib/ar_async_counter_cache/active_record.rb",
     "lib/ar_async_counter_cache/increment_counters_worker.rb",
     "spec/ar_async_counter_cache/active_record_spec.rb",
     "spec/integration_spec.rb",
     "spec/models.rb",
     "spec/redis-test.conf",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/agibralter/ar-async-counter-cache}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Increment ActiveRecord's counter cache column asynchronously using Resque (and resque-lock-timeout).}
  s.test_files = [
    "spec/ar_async_counter_cache/active_record_spec.rb",
     "spec/integration_spec.rb",
     "spec/models.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, ["~> 2.3.5"])
      s.add_runtime_dependency(%q<resque>, ["~> 1.10.0"])
      s.add_runtime_dependency(%q<resque-lock-timeout>, ["~> 0.2.1"])
    else
      s.add_dependency(%q<activerecord>, ["~> 2.3.5"])
      s.add_dependency(%q<resque>, ["~> 1.10.0"])
      s.add_dependency(%q<resque-lock-timeout>, ["~> 0.2.1"])
    end
  else
    s.add_dependency(%q<activerecord>, ["~> 2.3.5"])
    s.add_dependency(%q<resque>, ["~> 1.10.0"])
    s.add_dependency(%q<resque-lock-timeout>, ["~> 0.2.1"])
  end
end

