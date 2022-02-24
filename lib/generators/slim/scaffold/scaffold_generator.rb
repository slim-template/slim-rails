require 'rails/generators/erb/scaffold/scaffold_generator'

module Slim
  module Generators
    class ScaffoldGenerator < Erb::Generators::ScaffoldGenerator # :nodoc:
      source_root File.expand_path(File.join('..', 'templates'), __FILE__)

      def copy_view_files
        available_views.each do |view|
          filename = filename_with_extensions view
          template "#{view}.html.slim", File.join('app', 'views', controller_file_path, filename)
        end

        template 'partial.html.slim', File.join('app/views', controller_file_path, "_#{singular_name}.html.slim")
      end

      hook_for :form_builder, as: :scaffold

      protected

      def available_views
        %w[index edit show new _form]
      end

      def handler
        :slim
      end
    end
  end
end
