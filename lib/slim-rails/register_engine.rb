module Slim
  module Rails
    module RegisterEngine
      def self.register_engine(app, config)
        if ::Rails::VERSION::MAJOR == 3
          register_engine3(app, config)
        else
          register_engine4(app, config)
        end
      end

      private

      def self.register_engine3(app, _config)
        return unless app.assets
        return unless app.assets.respond_to?(:register_engine)

        app.assets.register_engine('.slim', Slim::Template)
      end

      def self.register_engine4(_app, config)
        return unless config.respond_to?(:assets)

        config.assets.configure do |env|
          env.register_engine('.slim', Slim::Template)
        end
      end
    end
  end
end
