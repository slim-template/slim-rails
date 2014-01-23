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

      # Configure cache digests to parse slim view templates when calculating
      # cache keys for view fragments
      initializer 'slim_rails.configure_template_digestor' do
        ActiveSupport.on_load(:action_view) do
          ActiveSupport.on_load(:after_initialize) do
            if defined?(CacheDigests::DependencyTracker)
              # 'cache_digests' gem being used (overrides Rails 4 implementation)
              CacheDigests::DependencyTracker.register_tracker :slim, CacheDigests::DependencyTracker::ERBTracker

              if ::Rails.env.development?
                # recalculate cache digest keys for each request
                CacheDigests::TemplateDigestor.cache = ActiveSupport::Cache::NullStore.new
              end
            else
              # will only apply if Rails 4, which includes 'action_view/dependency_tracker'
              require 'action_view/dependency_tracker'
              ActionView::DependencyTracker.register_tracker :slim, ActionView::DependencyTracker::ERBTracker
            end
          end
        end
      end
    end
  end
end
