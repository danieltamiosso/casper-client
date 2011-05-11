# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "casper-client"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Daniel Tamiosso"]
  s.email       = ["email@danieltamiosso.com"]
  s.homepage    = "https://github.com/danieltamiosso/casper-client"
  s.summary     = %q{just a simple api for casper service}
  s.description = %q{just a simple api for casper service (a web server framework for JasperReports)}
  
  s.required_rubygems_version = ">= 1.3.6"
  s.add_development_dependency "rspec", ">= 2.5.0"
  s.add_dependency "rest-client", ">= 0"  
  s.add_dependency "bundler", ">= 0"
  
  s.rubyforge_project = "casper-client"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = ["lib"]
end
