#!/usr/bin/env ruby
##############################################
# This is the Rainpress standalone excutable #
##############################################
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

require 'getoptlong'
require 'gettext'
# Do not include rainpress/packer via global include, this might include
# a false file, we want the Packer version which is shipped with this file.
require File.join(File.dirname(__FILE__), 'rainpress', 'packer')

## Var Init ##

opts = GetoptLong.new(
  ['--help', '-h', GetoptLong::NO_ARGUMENT],
  ['--input', '-i', GetoptLong::REQUIRED_ARGUMENT],
  ['--output', '-o', GetoptLong::REQUIRED_ARGUMENT]
)

$infile = nil
$outfile = nil

GetText::bindtextdomain('rainpress', 'locale')

## Functions ##

# Explain to the user how to use Rainpress
# 
# After displaying this usage information exit the program.
# The messages in this functions are the only things to translate. The 
# translation files could be found in the locales/ directory, but translation 
# should be done via https://translations.launchpad.net/rainpress/ . The 
# translations done there could be exported and merged into the software. We
# use Launchpad since it provides a nice interface for the translation process.
def usage
  puts 'Rainpress -- CSS compressor |'
  puts '----------------------------|'
  puts ''
  puts '--help, -h                 ' + GetText::_('Display this help')
  puts '--input, -i <file>         ' + GetText::_('The CSS-file to be compressed, if not set stdin is used')
  puts '--output, -o <file>        ' + GetText::_('The output file, if not set, stdout is used')
  exit
end

## Main ##

opts.each do |opt, arg|
  case opt
    when '--help'
      usage()
    when '--input'
      $infile = arg
    when '--output'
      $outfile = arg   
  end
end

# Check if a input file is set, if not than read from stdin
if $infile == nil
  $input = STDIN.read
else
  $input = File.read($infile)
end

# Create a new Rainpress::Packer instance which we'll use for compressing
packer = Rainpress::Packer.new
# Compress the inputted text
$output = packer.compress($input)

# Check if a output file is set, if not write to stdout
if $outfile == nil
  puts $output
else 
  # TODO: Is there no Ruby equivalent to PHP's file_put_contents ?
  File.open($outfile, 'w') do |f|
    f.write $output
  end
end
