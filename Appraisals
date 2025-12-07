appraise "rails-5.2" do
  gem "rails", "~> 5.2.7"
end

appraise "rails-6.0" do
  gem "rails", "~> 6.0.4"

  # for ruby 3.4+
  gem "base64"
  gem "bigdecimal"
  gem "mutex_m"
  gem "drb"

  # Fix https://github.com/rails/rails/issues/54260
  gem "concurrent-ruby", "1.3.4"
end

appraise "rails-6.1" do
  gem "rails", "~> 6.1.5"

  # for ruby 3.4+
  gem "base64"
  gem "bigdecimal"
  gem "mutex_m"
  gem "drb"

  # Fix https://github.com/rails/rails/issues/54260
  gem "concurrent-ruby", "1.3.4"
end

appraise "rails-7.0" do
  gem "rails", "~> 7.0.2"
  gem "sprockets-rails"

  # for ruby 3.4+
  gem "base64"
  gem "bigdecimal"
  gem "mutex_m"
  gem "drb"

  # Fix https://github.com/rails/rails/issues/54260
  gem "concurrent-ruby", "1.3.4"
end

appraise "rails-7.1" do
  gem "rails", "~> 7.1.0"
  gem "sprockets-rails"
end

appraise "rails-7.2" do
  gem "rails", "~> 7.2.0"
  gem "sprockets-rails"
end

appraise "rails-8.0" do
  gem "rails", "~> 8.0.0"
  gem "bcrypt"
  gem "propshaft"
end

appraise "rails-8.0-sprockets" do
  gem "rails", "~> 8.0.0"
  gem "bcrypt"
  gem "sprockets-rails"
end

appraise "rails-8.1" do
  gem "rails", "~> 8.1.0"
  gem "bcrypt"
  gem "propshaft"
end

appraise "rails-8.1-sprockets" do
  gem "rails", "~> 8.1.0"
  gem "bcrypt"
  gem "sprockets-rails"
end

appraise "rails-edge" do
  gem "rails", github: "rails/rails", branch: "main"
  gem "bcrypt"
  gem "sprockets-rails"
end
