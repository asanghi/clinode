# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "clinode/version"

Gem::Specification.new do |s|
  s.name        = "clinode"
  s.version     = Clinode::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Aditya Sanghi"]
  s.email       = ["asanghi@me.com"]
  s.homepage    = "http://me.adityasanghi.com"
  s.summary     = %q{Command Line Control over your Linodes}
  s.description = %q{Extensive control of your linode(s) using a fully featured command line tool}

  s.rubyforge_project = "clinode"

  s.files           = `git ls-files`.split("\n")
  s.test_files      = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables     = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths   = ["lib"]

  s.add_dependency  "linode", "~> 0.7.1"
  s.add_dependency "text-hyphen", "1.0.0"
  s.add_dependency "text-format", "1.0.0"
  s.add_dependency "highline", "~> 1.5.1"
  s.add_dependency "json_pure", "~> 1.5.1"

  s.add_development_dependency "rspec"
end
