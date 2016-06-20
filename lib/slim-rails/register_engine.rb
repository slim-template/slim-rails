module Slim
  module Rails
    module RegisterEngine
      def self.register_engine(app, config)
        if ::Rails::VERSION::MAJOR == 3
          if app.assets && app.assets.respond_to?(:register_engine)
            app.assets.register_engine('.slim', Slim::Template)
          end
        else
          config.assets.configure do |env|
            env.register_engine('.slim', Slim::Template)
          end if config.respond_to?(:assets)
        end
      end
    end
  end
end
