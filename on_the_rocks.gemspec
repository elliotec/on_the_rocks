# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'on_the_rocks/version'

Gem::Specification.new do |spec|
  spec.name          = "on_the_rocks"
  spec.version       = OnTheRocks::VERSION
  spec.authors       = ["Michael Elliott"]
  spec.email         = ["me@michaelelliott.me"]
  spec.summary       = %q{Bourbon, Neat, and Bitters all in one happy package.}
  spec.description   = %q{This gem combines my favorite Sass libraries: Bourbon, Neat, and Bitters by Thoughtbot. It also adds Normalize and installs them all, setting up a nice Sass file structure. }
  spec.homepage      = "http://github.com/elliotec/on_the_rocks"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.executables   = ["on_the_rocks"]
  
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~> 5.4"

  spec.add_dependency "bourbon", "~> 4.0"
  spec.add_dependency "neat", "~> 1.6"
  spec.add_dependency "bitters", "~> 0.10"
end
