# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "signnow/version"

Gem::Specification.new do |s|
  s.name        = "signnow"
  s.version     = Signnow::VERSION
  s.authors     = ["Andres Bravo"]
  s.email       = ["hola@andresbravo.com"]
  s.homepage    = "https://github.com/andresbravog/signnow-ruby"
  s.summary     = %q{API wrapper for Signnow.}
  s.description = %q{API wrapper for Signnow.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "json"
  s.add_development_dependency "rspec"
  s.add_development_dependency "pry"
end
