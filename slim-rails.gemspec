# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slim-rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'slim-rails'
  spec.version       = Slim::Rails::VERSION
  spec.authors       = ["Leonardo Almeida"]
  spec.email         = ["lalmeida08@gmail.com"]

  spec.summary       = 'Slim templates generator for Rails 3 and 4'
  spec.description   = 'Provides the generator settings required for Rails 3 and 4 to use Slim'
  spec.homepage      = 'https://github.com/slim-template/slim-rails'
  spec.license       = 'MIT'

  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_runtime_dependency 'actionpack', ['>= 3.1', '< 5.0']
  spec.add_runtime_dependency 'railties',   ['>= 3.1', '< 5.0']
  spec.add_runtime_dependency 'slim',       ['~> 3.0']

  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_development_dependency 'rocco', '~> 0.8'
  spec.add_development_dependency 'redcarpet', '~> 3.2'
  spec.add_development_dependency 'awesome_print', '~> 1.2'
  spec.add_development_dependency 'actionmailer', ['>= 3.1']

end
