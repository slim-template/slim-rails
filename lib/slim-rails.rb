# frozen_string_literal: true

require "slim-rails/version"
require "rails"
require "slim"
require "slim-rails/register_engine"

module Slim
  module Rails
    class Railtie < ::Rails::Railtie
      config.app_generators.template_engine :slim

      initializer "slim_rails.configure_template_digestor" do |app|
        Slim::Rails::RegisterEngine.register_engine(app, config)

        ActiveSupport.on_load(:action_view) do
          ActiveSupport.on_load(:after_initialize) do
            begin # rubocop:disable Style/RedundantBegin
              require "action_view/dependency_tracker"
              tracker = if defined?(ActionView::DependencyTracker::RubyTracker)
                ActionView::DependencyTracker::RubyTracker
              else
                ActionView::DependencyTracker::ERBTracker
              end
              ActionView::DependencyTracker.register_tracker :slim, tracker
            rescue
              # likely this version of Rails doesn't support dependency tracking
            end
          end
        end
      end

      if ::Rails::VERSION::MAJOR >= 8 && ::Rails::VERSION::MINOR >= 2
        initializer "slim_rails.configure_code_statistics" do
          require "rails/code_statistics"

          ::Rails::CodeStatistics.register_extension("slim")
        end
      end

      initializer "slim_rails.configure_source_annotation" do
        require "rails/source_annotation_extractor"

        ::Rails::SourceAnnotationExtractor::Annotation.register_extensions("slim") do |tag|
          /\s*\/\s*(#{tag}):?\s*(.*)$/
        end
      end
    end
  end
end
