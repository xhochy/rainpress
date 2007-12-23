#!/usr/bin/env ruby
######################################
## The main Rakefile for Drossellog ##
######################################

## Includes ##

require 'rake/clean'

## Config ##

doc = {
  'Files' => FileList['*.rb', 'rainpress/*.rb'],
  'Title' => 'Rainpress'
}

## Tasks ##

task :test do
  require 'rainpress/test_packer.rb'
  require 'test/unit/ui/console/testrunner'
  Test::Unit::UI::Console::TestRunner.run(Rainpress::TestPacker)
end

task :doc => ['doc/index.html']
task :all => [:test, :doc]
task :default => [:all]


## clean Task ##

CLEAN.include('doc/')

## File Tasks ##

file 'doc/index.html' => doc['Files'] do
  Rake::Task[:clean].invoke
  
  cmd = 'rdoc --title ' + doc['Title']
  cmd+= ' --all --diagram --image-format png --inline-source --line-numbers '
  cmd+= '--op doc/ --tab-width 4'
  sh cmd
end 