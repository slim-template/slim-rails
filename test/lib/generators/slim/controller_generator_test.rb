require 'test_helper'
require 'lib/generators/slim/testing_helper'

class Slim::Generators::ControllerGeneratorTest < Rails::Generators::TestCase
  include SlimLintHelpers

  destination File.join(Rails.root)
  tests Rails::Generators::ControllerGenerator
  arguments %w(Account foo bar --template-engine slim)

  setup :prepare_destination
  setup :copy_routes

  test "should invoke template engine" do
    run_generator
    assert_file File.join("app", "views", "account", "foo.html.slim"), %r(app/views/account/foo\.html\.slim)
    assert_file File.join("app", "views", "account", "bar.html.slim"), %r(app/views/account/bar\.html\.slim)
  end

  test "should generate SlimLint valid templates" do
    run_generator
    templates = Dir[File.join(Rails.root, 'app', 'views', '**', '*.slim')]
    assert_empty lint(templates)
  end
end
