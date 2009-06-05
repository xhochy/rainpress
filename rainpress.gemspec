# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rainpress}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Uwe L. Korn"]
  s.date = %q{2009-06-05}
  s.default_executable = %q{rainpress}
  s.description = %q{Rainpress does not apply common compression algorithms like gzip, it removes unnecessary characters and replaces some attributes with a shorter equivalent name}
  s.email = %q{uwelk@xhochy.org}
  s.executables = ["rainpress"]
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "README.rdoc",
     "Rakefile",
     "VERSION.yml",
     "bin/rainpress",
     "lib/rainpress.rb",
     "lib/rainpress_test.rb"
  ]
  s.homepage = %q{http://rainpress.xhochy.com/}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Rainpress is a compressor for CSS. It's written in ruby, but should not be limited to ruby projects.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
