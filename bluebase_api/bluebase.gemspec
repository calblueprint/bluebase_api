# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bluebase/version'

Gem::Specification.new do |spec|
  spec.name          = "bluebase"
  spec.version       = Bluebase::VERSION
  spec.authors       = ["Sam Lau", "Cal Blueprint"]
  spec.email         = ["team@calblueprint.org"]
  spec.summary       = "Bluebase creates a Rails app with all of our favorite defaults."
  spec.description   = <<-HERE
Bluebase is Blueprint's base Rails app. We use it internally to get a jump start on our Rails projects.
  HERE
  spec.homepage      = "https://github.com/calblueprint/bluebase"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= #{Bluebase::RUBY_VERSION}"

  spec.add_runtime_dependency "rails", Bluebase::RAILS_VERSION
  spec.add_runtime_dependency "bundler", "~> 1.6"

  spec.add_development_dependency "rspec", "~> 3.2", ">= 3.2.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "capybara", "~> 2.4"
end
