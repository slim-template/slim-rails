require "test_helper"
require "lib/generators/slim/testing_helper"

if ::Rails::VERSION::MAJOR >= 8
  class Slim::Generators::AuthenticationGeneratorTest < Rails::Generators::TestCase
    include SlimLintHelpers

    destination File.join(Rails.root)
    tests Rails::Generators::AuthenticationGenerator
    arguments %w[--template-engine slim]

    setup :prepare_destination
    setup :copy_routes
    setup :copy_application_controller
    setup :copy_gemfile

    test "should invoke template engine" do
      run_generator_instance

      assert_file File.join("app", "views", "sessions", "new.html.slim")
      assert_file File.join("app", "views", "passwords", "new.html.slim")
      assert_file File.join("app", "views", "passwords", "edit.html.slim")
    end

    test "should generate SlimLint valid templates" do
      run_generator_instance

      templates = Dir[File.join(Rails.root, "app", "views", "**", "*.slim")]
      assert_empty lint(templates)
    end

    private

    def run_generator_instance
      commands = []
      command_stub ||= ->(command, *args) { commands << [command, *args] }

      content = nil
      generator.stub(:execute_command, command_stub) do
        content = capture(:stdout) do
          generator.invoke_all
        end
      end

      content
    end
  end
end
