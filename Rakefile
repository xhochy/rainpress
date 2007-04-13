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

task :doc => ['doc/index.html']
task :devel => [:doc]
task :default => [:devel, :test]

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