# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omise/bot/version'

Gem::Specification.new do |spec|
  spec.name          = "omise-bot"
  spec.version       = Omise::Bot::VERSION
  spec.authors       = ["Robin Clart"]
  spec.email         = ["robin@omise.co"]

  spec.summary       = %q{Omise Bot Framework}
  spec.homepage      = "https://github.com/omise/bot"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
