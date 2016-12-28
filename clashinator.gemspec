# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clashinator/version'

Gem::Specification.new do |spec|
  spec.name          = "clashinator"
  spec.version       = Clashinator::VERSION
  spec.authors       = ["Leonardo Cabeza"]
  spec.email         = ["info@leonardocabeza.com"]

  spec.summary       = %q{Ruby wrapper for the Clash of Clans API}
  spec.homepage      = "https://github.com/leocabeza/clash-api"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  # spec.add_development_dependency "webmock", "~> 2.1", ">= 2.1.0"
  # spec.add_development_dependency "vcr", "~> 3.0", ">= 3.0.3"
  spec.add_development_dependency "minitest", "~> 5.9", ">= 5.9.1"

  spec.add_dependency "faraday", "~> 0.10.0"
  spec.add_dependency "json", "~> 2.0.2"
end
