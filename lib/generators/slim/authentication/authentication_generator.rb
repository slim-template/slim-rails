require "rails/generators/erb/authentication/authentication_generator"

module Slim
  module Generators
    class AuthenticationGenerator < Erb::Generators::AuthenticationGenerator
      source_root File.expand_path(File.join("..", "templates"), __FILE__)

      def create_files
        template "sessions/new.html.slim", "app/views/sessions/new.html.slim"
        template "passwords/new.html.slim", "app/views/passwords/new.html.slim"
        template "passwords/edit.html.slim", "app/views/passwords/edit.html.slim"
      end

      protected

      def handler
        :slim
      end
    end
  end
end
