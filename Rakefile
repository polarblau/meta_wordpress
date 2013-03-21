require 'bundler'
Bundler::GemHelper.install_tasks
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:rspec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = ['-cfs --backtrace --color']
end

task :simpleunit do
  system "php test/layout_test.php"
end

task :test_all do
  Rake::Task["rspec"].invoke
  Rake::Task["simpleunit"].invoke
end

task :default => :test_all
