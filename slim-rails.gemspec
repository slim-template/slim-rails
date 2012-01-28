# -*- encoding: utf-8 -*-

  s.version = "0.2.0"
Gem::Specification.new do |gem|

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Leonardo Almeida"]
  s.date = %q{2010-11-05}
  s.description = %q{Provide generators for Rails 3}
  s.email = %q{lalmeida08@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.md"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.md",
     "Rakefile",
     "lib/generators/slim/controller/controller_generator.rb",
     "lib/generators/slim/controller/templates/view.html.slim",
     "lib/generators/slim/mailer/mailer_generator.rb",
     "lib/generators/slim/mailer/templates/view.text.slim",
     "lib/generators/slim/scaffold/scaffold_generator.rb",
     "lib/generators/slim/scaffold/templates/_form.html.slim",
     "lib/generators/slim/scaffold/templates/edit.html.slim",
     "lib/generators/slim/scaffold/templates/index.html.slim",
     "lib/generators/slim/scaffold/templates/new.html.slim",
     "lib/generators/slim/scaffold/templates/show.html.slim",
     "lib/slim-rails.rb",
     "lib/slim-rails/version.rb",
     "slim-rails.gemspec",
     "test/fixtures/routes.rb",
     "test/lib/generators/slim/controller_generator_test.rb",
     "test/lib/generators/slim/mailer_generator_test.rb",
     "test/lib/generators/slim/scaffold_generator_test.rb",
     "test/lib/generators/slim/testing_helper.rb",
     "test/test_helper.rb",
     "tmp/rails/config/routes.rb",
     "tmp/rails/public/stylesheets/scaffold.css"
  ]
  s.homepage = %q{http://github.com/leogalmeida/slim-rails}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Provides generators for Rails 3}
  s.test_files = [
    "test/fixtures/routes.rb",
     "test/lib/generators/slim/controller_generator_test.rb",
     "test/lib/generators/slim/mailer_generator_test.rb",
     "test/lib/generators/slim/scaffold_generator_test.rb",
     "test/lib/generators/slim/testing_helper.rb",
     "test/test_helper.rb"
  ]
  gem.name          = 'slim-rails'

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

