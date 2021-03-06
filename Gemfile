source "https://rubygems.org"

ruby "2.3.1"

gem "rails", "4.2.7.1"
gem "pg"

# assets
gem "autoprefixer-rails"
gem "font-awesome-sass"
gem "foundation-icons-sass-rails"
gem "foundation-rails"
gem "premailer-rails"
gem "sass-rails", "~> 5.0.0"
gem "therubyracer", platforms: :ruby
gem "uglifier", ">= 2.7.2"
gem "webpack-rails"

# views
gem "active_link_to"
gem "inky-rb", require: "inky"
gem "metamagic"
gem "simple_form"
gem "slim"

# all other gems
gem "active_model_serializers"
gem "activeadmin", git: "https://github.com/activeadmin/activeadmin"
gem "decent_decoration"
gem "decent_exposure"
gem "devise"
gem "draper"
gem "enumerize"
gem "flamegraph"
gem "google-analytics-rails"
gem "health_check"
gem "interactor"
gem "kaminari"
gem "memory_profiler"
gem "pg_search"
gem "puma"
gem "pundit"
gem "rack-canonical-host"
gem "rack-mini-profiler", require: false
gem "responders"
gem "rollbar"
gem "seedbank"
gem "stackprof"

group :staging, :production do
  gem "newrelic_rpm"
  gem "rails_stdout_logging"
end

group :development, :test, :staging do
  gem "factory_girl_rails"
  gem "faker"
end

group :test do
  gem "capybara"
  gem "capybara-webkit"
  gem "capybara-screenshot"
  gem "codeclimate-test-reporter", require: false
  gem "database_cleaner"
  gem "email_spec"
  gem "formulaic"
  gem "launchy"
  gem "rspec-its"
  gem "shoulda-matchers"
  gem "webmock", require: false
end

group :development, :test do
  gem "awesome_print"
  gem "brakeman", require: false
  gem "bundler-audit", require: false
  gem "byebug"
  gem "dotenv-rails"
  gem "jasmine", "> 2.0"
  gem "jasmine-jquery-rails"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.4"
  gem "rubocop", require: false
  gem "rubocop-rspec", require: false
  gem "scss_lint", require: false
  gem "slim_lint", require: false
end

group :development do
  gem "bullet"
  gem "foreman", require: false
  gem "letter_opener"
  gem "quiet_assets"
  gem "rails-erd"
  gem "slim-rails"
  gem "spring"
  gem "spring-commands-rspec"
  gem "web-console", "~> 2.0"
end
