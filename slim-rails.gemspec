# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slim-rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'slim-rails'
  spec.version       = Slim::Rails::VERSION
  spec.authors       = ["Leonardo Almeida"]
  spec.email         = ["lalmeida08@gmail.com"]

  spec.summary       = 'Slim templates generator for Rails 3+'
  spec.description   = 'Provides the generator settings required for Rails 3+ to use Slim'
  spec.homepage      = 'https://github.com/slim-template/slim-rails'
  spec.license       = 'MIT'

  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_runtime_dependency 'actionpack', ['>= 3.1']
  spec.add_runtime_dependency 'railties',   ['>= 3.1']
  spec.add_runtime_dependency 'slim',       ['~> 3.0']

  spec.add_development_dependency 'sprockets-rails'
  spec.add_development_dependency 'rocco'
  spec.add_development_dependency 'redcarpet'
  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'actionmailer', ['>= 3.1']
  spec.add_development_dependency 'appraisal'
end
