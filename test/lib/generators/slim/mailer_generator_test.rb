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

    rails_version = ::Rails.version.to_s

    if rails_version >= '5.0'
      assert_file "app/views/notifier_mailer/foo.html.slim" do |view|
        assert_match %r(app/views/notifier_mailer/foo\.html\.slim), view
        assert_match(/\= @greeting/, view)
      end

      assert_file "app/views/notifier_mailer/bar.html.slim" do |view|
        assert_match %r(app/views/notifier_mailer/bar\.html\.slim), view
        assert_match(/\= @greeting/, view)
      end

      assert_file "app/views/notifier_mailer/foo.text.slim" do |view|
        assert_match %r(app/views/notifier_mailer/foo\.text\.slim), view
        assert_match(/@greeting/, view)
      end

      assert_file "app/views/notifier_mailer/bar.text.slim" do |view|
        assert_match %r(app/views/notifier_mailer/bar\.text\.slim), view
        assert_match(/@greeting/, view)
      end
    else
      if rails_version >= '4.2'
        assert_file "app/views/layouts/mailer.text.slim" do |view|
          assert_match(/\= yield/, view)
        end

        assert_file "app/views/layouts/mailer.html.slim" do |view|
          assert_match(/\= yield/, view)
        end

        assert_file "app/views/notifier/foo.html.slim" do |view|
          assert_match %r(app/views/notifier/foo\.html\.slim), view
          assert_match(/\= @greeting/, view)
        end

        assert_file "app/views/notifier/bar.html.slim" do |view|
          assert_match %r(app/views/notifier/bar\.html\.slim), view
          assert_match(/\= @greeting/, view)
        end

      end

      assert_file "app/views/notifier/foo.text.slim" do |view|
        assert_match %r(app/views/notifier/foo\.text\.slim), view
        assert_match(/@greeting/, view)
      end

      assert_file "app/views/notifier/bar.text.slim" do |view|
        assert_match %r(app/views/notifier/bar\.text\.slim), view
        assert_match(/@greeting/, view)
      end
    end
  end
end
