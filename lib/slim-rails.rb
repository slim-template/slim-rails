require 'rails'
require 'slim'

module Slim
  module Rails
    class Railtie < ::Rails::Railtie
      if config.respond_to?(:generators)
        config.generators.template_engine :slim
      elsif config.respond_to?(:app_generators)
        config.app_generators.template_engine :slim
      end
    end
  end
end
