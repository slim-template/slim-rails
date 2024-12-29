require "rubygems"
require "minitest/autorun"
require "rails"
require "rails/test_help"
require "rails/generators"
require "rails/generators/test_case"
require "slim-rails"

class TestApp < Rails::Application
  config.root = File.dirname(__FILE__)
end
Rails.application = TestApp

module Rails
  def self.root
    @root ||= File.expand_path(File.join(File.dirname(__FILE__), "..", "tmp", "rails"))
  end
end
Rails.application.config.root = Rails.root

Rails::Generators.configure! Rails.application.config.generators

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

def copy_routes
  routes = File.expand_path(File.join(File.dirname(__FILE__), "fixtures", "routes.rb"))
  destination = File.join(Rails.root, "config")
  FileUtils.mkdir_p(destination)
  FileUtils.cp File.expand_path(routes), destination
end

def copy_application_controller
  app_controller = File.expand_path(File.join(File.dirname(__FILE__), "fixtures", "application_controller.rb"))
  destination = File.join(Rails.root, "app", "controllers")
  FileUtils.mkdir_p(destination)
  FileUtils.cp File.expand_path(app_controller), destination
end

def assert_class(klass, content)
  assert content =~ /class #{klass}(\(.+\))?(.*?)\nend/m, "Expected to have class #{klass}"
  yield $2.strip if block_given?
end

def generator_list
  if ::Rails::VERSION::MAJOR >= 8
    {
      rails: ["scaffold", "controller", "mailer", "authentication"],
      slim: ["scaffold", "controller", "mailer", "authentication"]
    }
  else
    {
      rails: ["scaffold", "controller", "mailer"],
      slim: ["scaffold", "controller", "mailer"]
    }
  end
end

def path_prefix(name)
  case name
  when :rails
    "rails/generators"
  else
    "generators"
  end
end

def require_generators(generator_list)
  generator_list.each do |name, generators|
    generators.each do |generator_name|
      if name.to_s == "rails" && generator_name.to_s == "mailer"
        require File.join(path_prefix(name), generator_name.to_s, "#{generator_name}_generator")
      else
        require File.join(path_prefix(name), name.to_s, generator_name.to_s, "#{generator_name}_generator")
      end
    end
  end
end

# Cannot replace this with alias_method
alias require_generator require_generators # rubocop:disable Style/Alias

require_generators generator_list
