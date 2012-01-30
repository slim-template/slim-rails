require 'test_helper'
require 'lib/generators/slim/testing_helper'

class Slim::Generators::MailerGeneratorTest < Rails::Generators::TestCase
  destination File.join(Rails.root)
  tests Rails::Generators::MailerGenerator
  arguments %w(notifier foo bar --template-engine slim)

  setup :prepare_destination
  setup :copy_routes

  test "should invoke template engine" do
    run_generator
    assert_file File.join "app", "views", "notifier", "foo.text.slim" do |view|
      assert_match %r(app/views/notifier/foo\.text\.slim), view
      assert_match /\= @greeting/, view
    end

    assert_file File.join "app", "views", "notifier", "bar.text.slim" do |view|
      assert_match %r(app/views/notifier/bar\.text\.slim), view
      assert_match /\= @greeting/, view
    end
  end
end
