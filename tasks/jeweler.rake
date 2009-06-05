begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "rainpress"
    gemspec.summary = "Rainpress is a compressor for CSS. It's written in ruby, but should not be limited to ruby projects."
    gemspec.email = "uwelk@xhochy.org"
    gemspec.homepage = "http://rainpress.xhochy.com/"
    gemspec.description = "Rainpress does not apply common compression algorithms like gzip, it removes unnecessary characters and replaces some attributes with a shorter equivalent name"
    gemspec.authors = ["Uwe L. Korn"]
    gemspec.executables = 'rainpress'
    gemspec.files = FileList["[A-Z]*", "{bin,generators,lib,test}/**/*"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
