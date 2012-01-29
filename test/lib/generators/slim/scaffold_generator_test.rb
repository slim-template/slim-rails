require 'test_helper'
require 'lib/generators/slim/testing_helper'

class Slim::Generators::ScaffoldGeneratorTest < Rails::Generators::TestCase
  destination File.join(Rails.root)
  tests Rails::Generators::ScaffoldGenerator
  arguments %w(product_line title:string price:integer --template-engine slim)

  setup :prepare_destination
  setup :copy_routes

  test "should invoke template engine" do
    run_generator

    %w(index edit new show _form).each { |view| assert_file File.join "app", "views", "product_lines", "#{view}.html.slim" }
    assert_no_file File.join "app", "views", "layouts", "product_lines.html.slim"
  end

  test "should revoke template engine" do
    run_generator
    run_generator ["product_line"], :behavior => :revoke

    assert_no_file File.join "app", "views", "product_lines"
    assert_no_file File.join "app", "views", "layouts", "product_lines.html.slim"
  end

  test "should invoke form builder" do
    run_generator %w(product_line title:string price:integer --template-engine slim --form-builder some-form-builder)
    assert_no_file File.join "app", "views", "product_lines", "_form.html.slim"
  end
end
