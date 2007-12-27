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
  sh 'rcov rainpress_test.rb'
end

task :doc => ['doc/index.html']
task :all => [:test, :doc]
task :default => [:all]


## clean Task ##

CLEAN.include('doc/')
CLEAN.include('coverage/')

## File Tasks ##

file 'doc/index.html' => doc['Files'] do
  Rake::Task[:clean].invoke
  
  cmd = 'rdoc --title ' + doc['Title']
  cmd+= ' --all --diagram --image-format png --inline-source --line-numbers '
  cmd+= '--op doc/ --tab-width 4'
  sh cmd
end 