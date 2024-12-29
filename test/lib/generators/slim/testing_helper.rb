require "slim_lint"

module SlimLintHelpers
  EXCLUDED_LINTERS = %w[LineLength]

  def lint(templates)
    SlimLint::Runner.new.run(files: templates, excluded_linters: EXCLUDED_LINTERS).lints.map(&:message)
  end
end

if ::Rails::VERSION::MAJOR >= 8
  require_generators slim: ["scaffold", "controller", "mailer", "authentication"]
else
  require_generators slim: ["scaffold", "controller", "mailer"]
end
