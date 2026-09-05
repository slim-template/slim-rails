# frozen_string_literal: true

module Slim
  module Rails
    module RegisterEngine
      class Transformer
        def self.call(input)
          context = input[:environment].context_class.new(input)
          data = Slim::Template.new(input[:name]) { input[:data] }.render(context)
          context.metadata.merge(data: data)
        end
      end

      class << self
        def register_engine(app, config)
          _register_engine(config)
        end

        private

        def _register_engine(config)
          return unless config.respond_to?(:assets)

          config.assets.configure do |env|
            if env.respond_to?(:register_transformer) && Sprockets::VERSION.to_i > 3
              env.register_mime_type "text/slim", extensions: [".slim", ".slim.html"] # , charset: :html
              env.register_transformer "text/slim", "text/html", RegisterEngine::Transformer
            elsif env.respond_to?(:register_engine)
              args = [".slim", Slim::Template]
              args << {silence_deprecation: true} if Sprockets::VERSION.start_with?("3")
              env.register_engine(*args)
            end
          end
        end
      end
    end
  end
end
