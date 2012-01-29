require 'rails'
require 'slim'

module Slim
  module Rails
    class Railtie < ::Rails::Railtie
      unless ::Rails.version =~ /$3.1/
        config.generators.template_engine :slim
      else
        config.app_generators.template_engine :slim
      end
    end
  end
end
