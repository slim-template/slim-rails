require 'rails'
require 'slim'

module Slim
  module Rails
    class Railtie < ::Rails::Railtie
      begin
        config.app_generators.template_engine :slim
      rescue
        config.generators.template_engine :slim
      end
    end
  end
end
