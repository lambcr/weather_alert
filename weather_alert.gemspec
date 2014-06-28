# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'weather_alert/version'

Gem::Specification.new do |spec|
  spec.name          = "weather_alert"
  spec.version       = WeatherAlert::VERSION
  spec.authors       = ["Chris Lamb"]
  spec.email         = ["lamb.chrisr@gmail.com"]
  spec.summary       = %q{Weather alerter}
  spec.description   = %q{Sends the st pete forcast to others}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "hashie"
  spec.add_dependency "rest_client"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock"
end
