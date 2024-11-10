source "https://rubygems.org"

ruby "3.3.5"

gem "acts_as_list", "~> 1.1" # Add capabilities for sorting and reordering a number of objects in a list
# gem "bcrypt", "~> 3.1.7" # Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bootsnap", require: false # Reduces boot times through caching; required in config/boot.rb
gem "cpf_cnpj", "~> 0.5.0" # Validate CPF and CNPJ numbers
gem "devise", "~> 4.9" # Flexible authentication solution for Rails with Warden
gem "font-awesome-sass", "~> 6.5.2" # font-awesome-sass' is a Sass-powered version of Font Awesome
gem "foreman", "~> 0.88.1"  # Manage Procfile-based applications
# gem "image_processing", "~> 1.2" # Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "importmap-rails" # Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "jbuilder" # Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "kredis" # Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
gem "pagy", "~> 9.2.0" # The ultimate pagination ruby gem
gem "paranoia", "~> 3.0.0" # Soft delete for ActiveRecord
gem "pg", "~> 1.5" # Use PostgreSQL as the database for Active Record
gem "puma", ">= 5.0" # Use the Puma web server [https://github.com/puma/puma]
gem "rails", "~> 7.2.1" # Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails-i18n", "~> 7.0"  # Ruby on Rails I18n support
gem "redis", ">= 4.0.1" # Use Redis adapter to run Action Cable in production
gem "rubocop-rails-omakase", require: false # A curated RuboCop configuration for Rails projects following community best practices.
gem "solid_cable", "~> 3.0.2"
gem "sprockets-rails" # The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sqlite3", "~> 1.4" # Use sqlite3 as the database for Active Record
gem "stimulus-rails" # Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "tailwindcss-rails", "~> 2.6" # Use Tailwind CSS with Rails
gem "thruster", require: false # Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "turbo-rails" # Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "tzinfo-data", platforms: %i[ windows jruby ] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "rbs", "~> 3.5.3", require: false # RBS is a language for describing the structure of Ruby programs

group :development, :test do
  gem "debug", platforms: %i[ mri windows ] # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
end

group :development do
  gem "annotate", "~> 3.2.0" # Annotate Rails classes with schema and routes info
  gem "brakeman", "~> 6.2.1" # Brakeman is a static analysis tool which checks applications for security vulnerabilities
  gem "bullet", "~> 7.2.0"
  # gem "debugbar", "0.3.0" # Debugging toolbar for Rails applications
  gem "dotenv-rails", "~> 3.1.2" # Autoload dotenv in Rails.
  gem "dockerfile-rails", ">= 1.6" # Use Dockerfile templates for Rails development
  gem "factory_bot_rails", "~> 6.4.3" # Factory_bot is a fixtures replacement with a straightforward definition syntax
  gem "faker", "~> 3.4.2" # Faker is a port of Perl's Data::Faker library. It's a library for generating fake data such as names, addresses, and phone numbers.
  gem "htmlbeautifier", "~> 1.4.3" # Beautify HTML output in RSpec
  gem "lol_dba", "~> 2.4.0" # lol_dba is a small package of rake tasks that scan your application models and displays a list of columns that probably should be indexed
  gem "pghero", "~> 3.6.0" # A performance dashboard for Postgres
  gem "pg_query", "~> 5.1.0" # Parse and analyze SQL queries in Ruby
  gem "rack-mini-profiler" # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  gem "rspec-rails", "~> 7.0.1" # rspec-rails brings the RSpec testing framework to Ruby on Rails as a drop-in alternative to its default testing framework, Minitest.
  gem "ruby-lsp", ">= 0.20.0", require: false # Language Server Protocol for Ruby
  gem "ruby-lsp-rails", ">= 0.3.21", require: false # Ruby LSP Rails is a Ruby LSP addon for Rails projects.
  gem "ruby-lsp-rspec", require: false # Ruby LSP RSpec is a Ruby LSP addon for displaying CodeLens for RSpec tests.
  # gem "spring" # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  gem "web-console" # Use console on exceptions pages [https://github.com/rails/web-console]
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "shoulda-matchers", "~> 6.4.0" # Shoulda Matchers provides RSpec- and Minitest-compatible one-liners
end
