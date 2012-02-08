require 'generators/slim/controller/controller_generator'

module Slim
  module Generators
    class MailerGenerator < ControllerGenerator
      source_root File.expand_path(File.join('..', 'templates'), __FILE__)

      protected
      def format
        :text
      end

    end
  end
end
