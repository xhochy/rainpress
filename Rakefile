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

task :source_deb do 
  sh 'debuild -S -I.svn -us -uc'
end
task :source_deb => [:clean]

task :doc => ['doc/index.html']
task :all => [:test, :doc]
task :default => [:all]

task :publish_to_rainpress_xhochy_com => [:test, :doc]
task :publish_to_rainpress_xhochy_com do
  sh 'rm -rf /srv/www/port80/rainpress.xhochy.com/doc/'
  sh 'cp -r doc/ /srv/www/port80/rainpress.xhochy.com'
end


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