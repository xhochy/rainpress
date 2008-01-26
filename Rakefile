#!/usr/bin/env ruby
######################################
## The main Rakefile for Drossellog ##
######################################

## Includes ##

require 'rake/clean'
require 'gettext/utils'

## Config ##

doc = {
  'Files' => FileList['*.rb', File.join('rainpress', '*.rb')],
  'Title' => 'Rainpress'
}

## Tasks ##

desc 'Run unit tests'
task :test do
  sh 'rcov rainpress_test.rb'
end

desc 'Build pot-file from sourcecode'
task :build_pot => [File.join('locale', 'rainpress.pot')]
desc 'Complie *.po-files to binary mo\'s'
task :build_mo do
	GetText::create_mofiles(true, 'locale', 'locale')
end
desc 'Generate the sourcecode documentation'
task :doc => [File.join('doc', 'index.html')]

task :all => [:doc, :test]
task :default => [:all]

## XhochY specific Tasks ##

task :publish_to_rainpress_xhochy_com => [:doc, :test]
task :publish_to_rainpress_xhochy_com do
  sh 'rm -rf /srv/www/port80/rainpress.xhochy.com/doc/'
  sh 'rm -rf /srv/www/port80/rainpress.xhochy.com/coverage/'
  sh 'cp -r doc/ coverage/ /srv/www/port80/rainpress.xhochy.com'
end

## clean Task ##

CLEAN.include('doc')
CLEAN.include('coverage')
CLEAN.include('build-stamp')
CLEAN.include('configure-stamp')
CLEAN.include(File.join('debian', 'rainpress'))
CLEAN.include(File.join('debian', 'rainpress-doc'))
CLEAN.include(File.join('debian', 'files'))
CLEAN.include(File.join('locale', '*', 'LC_MESSAGES'));

## Deb(ian) Package Tasks ##  

desc 'Build debian-source-package'
task :source_deb => [:build_mo] do 
  sh 'debuild -S -I.svn -us -uc'
end
task :source_deb => [:clean]

desc 'Build debian-package using fakeroot'
task :binary_deb_fakeroot do
  sh 'dpkg-buildpackage -rfakeroot'
end
task :binary_deb_fakeroot => [:source_deb]

## File Tasks ##

file File.join('locale', 'rainpress.pot') => 'rainpress.rb' do
  sh 'rgettext rainpress.rb -o ' + File.join('locale', 'rainpress.pot')
  puts '!!! Remember to upload the updated pot-file to Launchpad/Translations !!!'
end

file File.join('doc', 'index.html') => doc['Files'] do
  sh "rm -rf doc"
  
  cmd = 'rdoc --title ' + doc['Title']
  cmd+= ' --all --diagram --image-format png --inline-source --charset UTF-8 '
  cmd+= '--op doc/ --tab-width 4'
  sh cmd
end 
