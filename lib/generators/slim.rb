require 'rails/generators/named_base'

module Slim
  module Generators
    class Base < Rails::Generators::NamedBase #:nodoc:
      protected

      def format
        :html
      end

      def handler
        :slim
      end

      def filename_with_extensions(name)
        [name, format, handler].compact.join(".")
      end
    end
  end
end