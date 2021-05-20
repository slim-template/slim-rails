require 'slim_lint'

module SlimLintHelpers
  EXCLUDED_LINTERS = %w[LineLength]

  def lint(templates)
    SlimLint::Runner.new.run(files: templates, excluded_linters: EXCLUDED_LINTERS).lints.map(&:message)
  end
end

require_generators slim: ['scaffold', 'controller', 'mailer']
