# -*- encoding: utf-8 -*-
require File.expand_path('../lib/slim-rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Leonardo Almeida"]
  gem.email         = ["lalmeida08@gmail.com"]
  gem.description   = 'Provides the generator settings required for Rails 3 to use Slim'
  gem.summary       = %q{Provides the generator settings required for Rails 3 to use Slim}
  gem.homepage      = 'http://github.com/leogalmeida/slim-rails'

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'slim-rails'
  gem.version       = Slim::Rails::VERSION

  s.add_dependency('slim', '>= 0.9.2')
  
  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

