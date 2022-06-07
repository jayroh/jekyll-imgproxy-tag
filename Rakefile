require 'rake/clean'

task(:default).clear
task default: [:spec]

desc 'Run tests'
task test: [:spec]

require 'rspec/core/rake_task'
desc 'Run RSpec'
RSpec::Core::RakeTask.new do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = ['--color']
end

require 'rake'

require 'rubygems/tasks'
Gem::Tasks.new do |tasks|
  tasks.console.command = 'pry'
end
