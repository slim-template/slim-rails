require 'slim-rails/version'
require 'rails'
require 'slim'

module Slim
  module Rails
    class Railtie < ::Rails::Railtie
      config.app_generators.template_engine :slim

      initializer 'slim_rails.configure_template_digestor' do |app|
        if app.assets && app.assets.respond_to?(:register_engine)
          app.assets.register_engine '.slim', Slim::Template
        end

        ActiveSupport.on_load(:action_view) do
          ActiveSupport.on_load(:after_initialize) do
            begin
              if defined?(CacheDigests::DependencyTracker)
                # 'cache_digests' gem being used (overrides Rails 4 implementation)
                CacheDigests::DependencyTracker.register_tracker :slim, CacheDigests::DependencyTracker::ERBTracker

                if ::Rails.env.development?
                  # recalculate cache digest keys for each request
                  CacheDigests::TemplateDigestor.cache = ActiveSupport::Cache::NullStore.new
                end
              elsif ::Rails.version.to_s >= '4.0'
                # will only apply if Rails 4, which includes 'action_view/dependency_tracker'
                require 'action_view/dependency_tracker'
                ActionView::DependencyTracker.register_tracker :slim, ActionView::DependencyTracker::ERBTracker
                ActionView::Base.cache_template_loading = false if ::Rails.env.development?
              end
            rescue
              # likely this version of Rails doesn't support dependency tracking
            end
          end
        end
      end
      if Gem::Requirement.new(">= 4.2").satisfied_by?(Gem::Version.new(::Rails.version))
        initializer 'slim_rails.configure_source_annotation' do
          SourceAnnotationExtractor::Annotation.register_extensions('slim') do |tag|
            /\s*-#\s*(#{tag}):?\s*(.*)/
          end
        end
      end
      
      rake_tasks do
        load 'tasks/erb2slim.rake'
      end
    end
  end
end

Slim::Engine.set_options pretty: Rails.env.development?

