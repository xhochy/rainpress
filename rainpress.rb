#!/usr/bin/env ruby

require 'getoptlong'
require File.join(File.dirname(__FILE__), 'rainpress', 'packer.rb')

## Functions ##

# Explain to the user how to use Drossellog
def usage
	puts 'Rainpress -- CSS compressor |'
  puts '----------------------------|'
  puts ''
  puts '--help, -h                 Display this help'
  puts '--input, -i <file>         The CSS-file to be compressed, if not set stdin is used'
  puts '--output, -o <file>        The output file, if not set, stdout is used'
  exit
end

## Var Init ##

opts = GetoptLong.new(
  ['--help', '-h', GetoptLong::NO_ARGUMENT],
  ['--input', '-i', GetoptLong::REQUIRED_ARGUMENT],
  ['--output', '-o', GetoptLong::REQUIRED_ARGUMENT]
)

$infile = nil
$outfile = nil

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

if $infile == nil
  $input = STDIN.read
else
  $input = File.read($infile)
end

packer = Rainpress::Packer.new
$output = packer.compress($input)

if $outfile == nil
  puts $output
else 
  File.open($outfile, 'w') do |f|
    f.write $output
  end
end