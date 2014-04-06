require 'bundler/gem_tasks'
require 'rake/testtask'

task :default => :test

Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  test.pattern = 'test/**/*test.rb'
end

