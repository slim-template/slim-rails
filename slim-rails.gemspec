# frozen_string_literal: true

require_relative "lib/slim-rails/version"

Gem::Specification.new do |spec|
  spec.name = "slim-rails"
  spec.version = Slim::Rails::VERSION
  spec.authors = ["Leonardo Almeida", "Janusz Mordarski"]
  spec.email = ["lalmeida08@gmail.com", "janusz.m@gmail.com"]

  spec.summary = "Slim templates generator for Rails"
  spec.description = "Provides the generator settings required for Rails to use Slim"
  spec.homepage = "https://github.com/slim-template/slim-rails"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/slim-template/slim-rails/releases"

  spec.files = Dir["{lib}/**/*", "README.md", "CHANGELOG.md", "LICENSE"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "actionpack", [">= 3.1"]
  spec.add_runtime_dependency "railties", [">= 3.1"]
  spec.add_runtime_dependency "slim", [">= 3.0", "!= 5.0.0", "< 6.0"]

  spec.add_development_dependency "actionmailer", [">= 3.1"]
  spec.add_development_dependency "appraisal"
  spec.add_development_dependency "standardrb"
  spec.add_development_dependency "slim_lint", ">= 0.24.0"
end
