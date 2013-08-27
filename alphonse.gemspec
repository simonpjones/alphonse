# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'alphonse/version'

Gem::Specification.new do |spec|
  spec.name          = "alphonse"
  spec.version       = Alphonse::Version::STRING
  spec.authors       = ["Simon Jones"]
  spec.email         = ["spj3rd@googlemail.com"]
  spec.description   = "Deploy like The Fonz"
  spec.summary       = "Rails deployment made easy."
  spec.homepage      = "http://simonjones.github.com/alphonse"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "pry", "~> 0.9"

  spec.add_runtime_dependency "net-ssh-session"
end
