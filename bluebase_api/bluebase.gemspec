# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bluebase_api/version'

Gem::Specification.new do |spec|
  spec.name          = "bluebase_api"
  spec.version       = Bluebase_api::VERSION
  spec.authors       = ["Sam Lau, Tricia Fu and Quinton Dang", "Cal Blueprint"]
  spec.email         = ["team@calblueprint.org"]
  spec.summary       = "Bluebase_api creates a Rails API app with all of our favorite defaults."
  spec.description   = <<-HERE
Bluebase_api is Blueprint's base Rails API app. We use it internally to get a jump start on our Rails projects.
  HERE
  spec.homepage      = "https://github.com/calblueprint/bluebase_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= #{Bluebase_api::RUBY_VERSION}"

  spec.add_runtime_dependency "rails", Bluebase_api::RAILS_VERSION
  spec.add_runtime_dependency "bundler", "~> 1.6"

  spec.add_development_dependency "rspec", "~> 3.2", ">= 3.2.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "capybara", "~> 2.4"
end
