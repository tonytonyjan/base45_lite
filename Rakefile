# frozen_string_literal: true

require 'rake/testtask'
require 'rubygems/package_task'

task default: :test

Rake::TestTask.new

spec = Gem::Specification.load("#{__dir__}/base45_lite.gemspec")
Gem::PackageTask.new(spec).define

task :benchmark do
  ruby '-Ilib', 'benchmark/main.rb'
end
