require 'test_helper'
require 'tmpdir'

class Slim::Rails::AssetsTest < ActiveSupport::TestCase
  def with_app(use_sprockets, code)
    Dir.mktmpdir do |dir|
      app_path = File.join(dir, 'app.rb')
      File.write(app_path, <<-APP)
      require 'rails'
      require 'sprockets/railtie' if #{use_sprockets}
      require 'slim-rails'
      class DummyApp < ::Rails::Application
        config.root = #{dir.inspect}
        config.assets.enabled = true if #{use_sprockets}
        config.eager_load = false
      end
      DummyApp.initialize!
      #{code}
      APP

      # Test HTML creation
      asset_path = File.join(dir, 'app', 'assets', 'html', 'test.slim')
      FileUtils.mkdir_p(File.dirname(asset_path))
      File.write(asset_path, ".test\n | hi")

      asset_path = File.join(dir, 'app', 'assets', 'html', 'test.js.slim')
      FileUtils.mkdir_p(File.dirname(asset_path))
      content = <<-EOH
        ruby:
          isTrue = true

        .test
          - if true
            javascript:
              var x = 42;
      EOH
      File.write(asset_path, content)

      `BUNDLE_GEMFILE=#{ENV['BUNDLE_GEMFILE']} bundle exec ruby #{app_path}`
    end
  end

  test 'compile slim view' do
    assert_equal 'ok', with_app(false, 'print DummyApp.assets || "ok"')
    assert_equal '<div class="test">hi</div>', with_app(true, 'print DummyApp.assets["test.slim"].to_s')
    assert_equal '<div class="test">hi</div>', with_app(true, 'print DummyApp.assets["test", accept: "text/html"].to_s')
  end

  test 'compile javascript slim view' do
    assert_equal 'ok', with_app(false, 'print DummyApp.assets || "ok"')
    assert_equal '<div class="test"><script>var x = 42;</script></div>', with_app(true, 'print DummyApp.assets["test.js.slim"].to_s.strip')
    assert_equal '<div class="test"><script>var x = 42;</script></div>', with_app(true, 'print DummyApp.assets["test.js.slim", accept: "text/html"].to_s')
  end
end
