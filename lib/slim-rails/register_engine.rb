module Slim
  module Rails
    module RegisterEngine
      def self.register_engine(app, config)
        if ::Rails::VERSION::MAJOR == 3
          _register_engine3(app)
        else
          _register_engine(config)
        end
      end

      private

      def self._register_engine3(app)
        return unless app.assets
        return unless app.assets.respond_to?(:register_engine)

        app.assets.register_engine('.slim', Slim::Template)
      end

      def self._register_engine(config)
        return unless config.respond_to?(:assets)

        config.assets.configure do |env|
          env.register_engine('.slim', Slim::Template)
        end
      end
    end
  end
end
