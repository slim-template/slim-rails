# -*- encoding: utf-8 -*-
require File.expand_path('../lib/slim-rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Leonardo Almeida"]
  gem.email         = ["lalmeida08@gmail.com"]
  gem.description   = 'Provides the generator settings required for Rails 3 to use Slim'
  gem.summary       = %q{Provides the generator settings required for Rails 3 to use Slim}
  gem.homepage      = 'http://github.com/leogalmeida/slim-rails'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'slim-rails'
  gem.require_paths = ['lib']
  gem.version       = Slim::Rails::VERSION

  gem.add_runtime_dependency 'activesupport', '~> 3.0'
  gem.add_runtime_dependency 'actionpack',    '~> 3.0'
  gem.add_runtime_dependency 'railties',      '~> 3.0'
  gem.add_runtime_dependency 'slim', '~> 1.0'
end

