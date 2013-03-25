require 'rails'
require 'slim'

module Slim
  module Rails
    class Railtie < ::Rails::Railtie              
      if ::Rails.version.to_s >= '3.1'
        config.app_generators.template_engine :slim        
      else
        config.generators.template_engine :slim
      end
    end
  end
end
