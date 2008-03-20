#!/usr/bin/env ruby
#####################################
## The main Rakefile for Rainpress ##
#####################################
#
#--
# Copyright (c) 2007-2008 Uwe L. Korn
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#++
#
# Author:: Uwe L. Korn <uwelk@xhochy.org>
# Copyright:: Copyright (c) 2007-2008 Uwe L. Korn
# License:: MIT-style License (see Rainpress)

## Includes ##

# Use the prewritten :clean Task from rake
require 'rake/clean'
# Use the gettext-utility functions for pot and mo generation
require 'gettext/utils'

## Config ##

doc = {
   # The location of all important Rainpress source files
  'Files' => FileList['*.rb', File.join('rainpress', '*.rb')],
  # The title of the API Documentation
  'Title' => 'Rainpress'
}

## Tasks ##

# Run the unit tests via rcov, so that we see which code is covered by
# the unit tests and which code needs additional tests written for. Our
# aim is that the tests for Rainpress should cover *all* code, if not
# it shouldn't be checked in before there are not enough tests.
#
# But remember: 100% Code coverage does not mean that the programm is 100% 
# correct!
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

# The API documentation should only be changed if there is a source code file
# which last modification time is higher than the modification time of the 
# index.html which is always regenerated during the API documentation building
# process.
desc 'Generate the sourcecode documentation'
task :doc => [File.join('doc', 'index.html')]

# If we want to build all, this just means we want to build the API 
# documentation and run the unit tests.
task :all => [:doc, :test]

# By default we build the task :all
task :default => [:all]

## XhochY specific Tasks ##

# This tasks is only used for the continous builds on xhochy.com, don't change!
# The location is fixed and the only place where this script has permission to
# write to.
# The output is visible via
# - http://rainpress.xhochy.com/test/ (The code coverage reports of the unittests)
# - http://rainpress.xhochy.com/doc/ (The API documentation)
task :publish_to_rainpress_xhochy_com => [:doc, :test]
task :publish_to_rainpress_xhochy_com do
  sh 'rm -rf /srv/www/port80/rainpress.xhochy.com/doc/'
  sh 'rm -rf /srv/www/port80/rainpress.xhochy.com/coverage/'
  sh 'cp -r doc/ coverage/ /srv/www/port80/rainpress.xhochy.com'
end

## clean Task ##

# Delete the API Documentation
CLEAN.include('doc')
# Delete the code coverage report
CLEAN.include('coverage')
# The flowing commands will delete the Debian-Package temporary files
CLEAN.include('build-stamp')
CLEAN.include('configure-stamp')
CLEAN.include(File.join('debian', 'rainpress'))
CLEAN.include(File.join('debian', 'rainpress-doc'))
CLEAN.include(File.join('debian', 'files'))
# Delete all binary translations (*.mo-files, not the *.po-files)
CLEAN.include(File.join('locale', '*', 'LC_MESSAGES'));

## Deb(ian) Package Tasks ##  

# Build a source Debian package package that could be either used for building
# a "binary" Debian package via pbuilder or for uploads in a APT repository.
desc 'Build debian-source-package'
task :source_deb => [:build_mo] do 
  sh 'debuild -S -I.svn -us -uc'
end
task :source_deb => [:clean]

# Builds a "binary" Debian package using the fakeroot command, packages created
# this way only tell us that the generation process has no problems. If you want
# to check if all build dependecies are remarked in debian/control, you should
# generate a source Debian package via `rake source_deb` and then use pbuilder 
# to build the "binary" package via `sudo pbuilder *.dsc`. Only this will ensure
# that the package could be build on standard configurations, since pbuilder
# builds the package in a clean chroot-environment.
desc 'Build debian-package using fakeroot'
task :binary_deb_fakeroot do
  sh 'dpkg-buildpackage -rfakeroot'
end
task :binary_deb_fakeroot => [:source_deb]

## File Tasks ##

# Builds the PO-template out of the ruby source code, at the moment we only have
# i18n strings in the rainpress.rb, we will ignore other i18n strings in other
# files. If there are any changes in the PO-template, the new version should be
# uploaded to https://translations.launchpad.net/rainpress/ so that there's
# always the up-to-date version, so that the translation keeps up with the 
# development.
file File.join('locale', 'rainpress.pot') => 'rainpress.rb' do
  sh 'rgettext rainpress.rb -o ' + File.join('locale', 'rainpress.pot')
  puts '!!! Remember to upload the updated pot-file to Launchpad/Translations !!!'
end

# Build the API documentation using RDoc, the include diagrams are made with
# graphviz, so this needs to installed on the developemnt system too.
file File.join('doc', 'index.html') => doc['Files'] do
  sh "rm -rf doc"
  
  cmd = 'rdoc --title ' + doc['Title']
  cmd+= ' --all --diagram --image-format png --inline-source --charset UTF-8 '
  cmd+= '--op doc/ --tab-width 4'
  sh cmd
end 
