require 'sprockets'
require 'test_helper'
require 'tmpdir'

class Slim::Rails::AssetsTest < ActiveSupport::TestCase
  def with_app(use_sprockets, code)
    Dir.mktmpdir do |dir|
      manifest_path = File.join(dir, 'app', 'assets', 'config', 'manifest.js')
      FileUtils.mkdir_p(File.dirname(manifest_path))
      File.write(manifest_path, '//= link_tree ../html .slim')

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

      if use_sprockets && Sprockets::VERSION.to_i >= 4
        manifest_path = File.join(dir, 'app', 'assets', 'config', 'manifest.js')
        FileUtils.mkdir_p(File.dirname(manifest_path))
        File.write(manifest_path, '')
      end

      asset_path = File.join(dir, 'app', 'assets', 'html', 'test.slim')
      FileUtils.mkdir_p(File.dirname(asset_path))
      File.write(asset_path, ".test\n  | hi")

      asset_path = File.join(dir, 'app', 'assets', 'html', 'test_helpers.slim')
      File.write(asset_path, '= logical_path')

      `BUNDLE_GEMFILE=#{ENV['BUNDLE_GEMFILE']} bundle exec ruby #{app_path}`
    end
  end

  test "should work without Sprockets" do
    assert_equal '', with_app(false, 'DummyApp.assets')
  end

  test "should return HTML version when passing 'text/html' content type" do
    assert_equal '<div class="test">hi</div>', with_app(true, 'print DummyApp.assets["test", accept: "text/html"]')
  end

  if Sprockets::VERSION.to_i < 4
    test "should return HTML version when passing '.slim' extension" do
      assert_equal '<div class="test">hi</div>', with_app(true, 'print DummyApp.assets["test.slim"]')
    end
  end

  if Sprockets::VERSION.to_i >= 3
    test "should return HTML version when passing '.html' extension" do
      assert_equal '<div class="test">hi</div>', with_app(true, 'print DummyApp.assets["test.html"]')
    end
  end

  if Sprockets::VERSION.to_i >= 4
    test "should return Slim version when passing '.slim' extension" do
      assert_equal ".test\n  | hi", with_app(true, 'print DummyApp.assets["test.slim"]')
    end
  end

  test "should work with asset helpers" do
    assert_equal 'test_helpers', with_app(true, 'print DummyApp.assets["test_helpers", accept: "text/html"]')
  end
end
