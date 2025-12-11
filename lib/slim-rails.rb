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
              if defined?(CacheDigests::DependencyTracker)
                # 'cache_digests' gem being used (overrides Rails 4 implementation)
                CacheDigests::DependencyTracker.register_tracker :slim, CacheDigests::DependencyTracker::ERBTracker

                if ::Rails.env.development?
                  # recalculate cache digest keys for each request
                  CacheDigests::TemplateDigestor.cache = ActiveSupport::Cache::NullStore.new
                end
              elsif ::Rails.version.to_s >= "4.0"
                # will only apply if Rails 4, which includes 'action_view/dependency_tracker'
                require "action_view/dependency_tracker"
                ActionView::DependencyTracker.register_tracker :slim, ActionView::DependencyTracker::ERBTracker
              end
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
        annotation_class = if ::Rails::VERSION::MAJOR >= 6
          require "rails/source_annotation_extractor"
          ::Rails::SourceAnnotationExtractor::Annotation
        else
          ::SourceAnnotationExtractor::Annotation
        end

        annotation_class.register_extensions("slim") do |tag|
          /\s*\/\s*(#{tag}):?\s*(.*)$/
        end
      end
    end
  end
end
