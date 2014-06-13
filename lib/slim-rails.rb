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
    end
  end
end
