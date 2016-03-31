# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'duplicate/version'

Gem::Specification.new do |spec|
  spec.name          = "duplicate"
  spec.version       = Duplicate::VERSION
  spec.authors       = ["Adam Luzsi"]
  spec.email         = ["adamluzsi@gmail.com"]

  spec.license       = 'Apache License Version 2.0'
  spec.summary       = %q{Deep duplication for ruby objects in pure ruby}
  spec.description   = %q{Originally extracted from rack-app project. Deep duplication for ruby objects in pure ruby, that allow you recursively duplicate objects based on a source object, even replacing original object references}
  spec.homepage      = "http://www.rack-app.com"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

end
