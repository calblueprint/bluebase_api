module Bluebase_api
  class AppBuilder < Rails::AppBuilder
    include Bluebase_api::Actions

    #########################################################
    # Root directory files
    #########################################################
    def readme
      template "README.md.erb", "README.md"
    end

    def replace_gemfile
      remove_file "Gemfile"
      template "Gemfile.erb", "Gemfile"
    end

    def add_envrc
      copy_file ".envrc", ".envrc"
    end

    def replace_gitignore
      remove_file ".gitignore"
      copy_file "bluebase_api_gitignore", ".gitignore"
    end

    def add_rubocop_and_hound_config
      copy_file ".hound.yml", ".hound.yml"
      copy_file ".rubocop.yml", ".rubocop.yml"
    end

    def add_rvm_config
      create_file ".ruby-gemset",  "#{app_path}\n"
      create_file ".ruby-version", "#{Bluebase_api::RUBY_VERSION}\n"
    end

    def add_guardfile
      copy_file "Guardfile", "Guardfile"
    end

    def add_dot_rspec
      copy_file ".rspec", ".rspec"
    end

    #########################################################
    # app/ directory files
    #########################################################

    # Only front-end changes were contained here, so removed for API app.
    def configure_api_directory
      empty_directory "app/controllers/api"
    end

    def configure_v1_directory
      empty_directory_with_keep_file "app/controllers/api/v1"
    end

    def add_base_controller
      template "app/controllers/api/base_controller.rb", "app/controllers/api/base_controller.rb"
    end

    def replace_application_controller
      file = "app/controllers/application_controller.rb"
      remove_file file
      template "app/controllers/bluebase_api_application_controller.rb", file
    end

    def add_serializers_directory
      empty_directory_with_keep_file "app/serializers"
    end

    def remove_app_assets_directory
      run "rm -rf app/assets"
    end

    def remove_app_views_directory
      run "rm -rf app/views"
    end

    #########################################################
    # vendor directory files
    #########################################################
    def remove_vendor_assets_directories
      run "rm -rf vendor"
      empty_directory_with_keep_file "vendor"
    end
    #########################################################
    # public/ directory files
    #########################################################
    def remove_html_files
      remove_file "public/404.html"
      remove_file "public/422.html"
      remove_file "public/500.html"
      run "rm -rf public/favicon.ico"
    end

    #########################################################
    # bin/ directory files
    #########################################################
    def add_setup_to_bin
      copy_file "bin/setup", "bin/setup"
      run "chmod a+x bin/setup"
    end
   
    #########################################################
    # lib/ directory files
    #########################################################
    def remove_lib_assets_directory
      run "rm -rf lib/assets"
    end

    #########################################################
    # tmp/ directory files
    #########################################################
    def remove_tmp_assets_directory
      run "rm -rf tmp/cache"
      empty_directory_with_keep_file "tmp/cache"
    end
    #########################################################
    # config/ directory files
    #########################################################
    def configure_application_environment
      config = <<-RUBY

    config.generators do |generate|
      generate.helper false
      generate.javascript_engine false
      generate.request_specs false
      generate.routing_specs false
      generate.stylesheets false
      generate.test_framework :rspec
      generate.view_specs false
    end

      RUBY
      inject_into_class "config/application.rb", "Application", config

      config = <<-RUBY
    config.active_record.default_timezone = :utc
      RUBY
      inject_into_class "config/application.rb", "Application", config

      config = <<-RUBY
    config.i18n.enforce_available_locales = true
      RUBY
      inject_into_class "config/application.rb", "Application", config

      config = <<-RUBY
    config.action_controller.action_on_unpermitted_parameters = :raise
      RUBY

      inject_into_class "config/application.rb", "Application", config
    end

    def configure_development_environment
      replace_in_file "config/environments/development.rb",
        "raise_delivery_errors = false", "raise_delivery_errors = true"
      inject_into_file "config/environments/development.rb",
        "  # Don't send emails in development\n  config.action_mailer.perform_deliveries = false",
        after: "raise_delivery_errors = true\n"
      raise_on_missing_translations_in "development"
      action_mailer_host "development", "localhost:3000"
    end

    def configure_test_environment
      raise_on_missing_translations_in "test"
    end

    def configure_production_environment
      prepend_file "config/environments/production.rb",
        %{require Rails.root.join("config/smtp")\n}

      config = <<-RUBY

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = SMTP_SETTINGS
      RUBY
      inject_into_file "config/environments/production.rb", config,
        after: "config.action_mailer.raise_delivery_errors = false"

      config = <<-RUBY

  # Enable deflate / gzip compression of controller-generated responses
  config.middleware.use Rack::Deflater
      RUBY
      inject_into_file "config/environments/production.rb", config,
        after: "config.serve_static_assets = false\n"

      action_mailer_host "production", "please-change-me.com"
    end

    def add_staging_environment
      template "config/staging.rb.erb", "config/environments/staging.rb"
    end

    def add_devise_config
      copy_file "config/devise.rb", "config/initializers/devise.rb"
    end

    def add_figaro_config
      copy_file "config/figaro.rb", "config/initializers/figaro.rb"
    end

    def replace_en_yml
      file = "config/locales/en.yml"
      remove_file file
      template "config/en.yml.erb", file
    end

    def add_application_yml
      template "config/application.yml.sample.erb", "config/application.yml.sample"

      template "config/application.yml.sample.erb", "config/application.yml"
      replace_in_file "config/application.yml",
        "# Copy this file into application.yml and change env variables as necessary.",
        "# Change env variables as necessary."
    end

    def add_database_yml
      template "config/database.yml.sample.erb", "config/database.yml.sample"

      remove_file "config/database.yml"
      template "config/database.yml.sample.erb", "config/database.yml"
      replace_in_file "config/database.yml",
        "# and then copy the file into database.yml", ""
    end

    def add_i18n_tasks_yml
      file = "config/i18n-tasks.yml"
      copy_file file, file
    end

    def replace_secrets_yml
      file = "config/secrets.yml"
      remove_file file
      copy_file "config/bluebase_api_secrets.yml", file
    end

    def add_smtp_settings
      file = "config/smtp.rb"
      copy_file file, file
    end

    def replace_routes_rb
      file = "config/routes.rb"
      remove_file file
      template "config/bluebase_api_routes.rb", file
    end

    #########################################################
    # spec/ directory files
    #########################################################
    def add_spec_dirs
      empty_directory "spec"
      empty_directory_with_keep_file "spec/features"
      empty_directory_with_keep_file "spec/factories"
    end

    def configure_rspec
      %w(spec/rails_helper.rb spec/spec_helper.rb).each do |file|
        copy_file file, file
      end
    end

    def configure_factorygirl
      copy_file "spec/factory_girl.rb", "spec/support/factory_girl.rb"
    end

    def configure_actionmailer
      copy_file "spec/action_mailer.rb", "spec/support/action_mailer.rb"
    end

    def configure_i18n
      copy_file "spec/i18n.rb", "spec/support/i18n.rb"
    end

    def configure_database_cleaner
      copy_file "spec/database_cleaner_and_factory_girl_lint.rb",
        "spec/support/database_cleaner_and_factory_girl_lint.rb"
    end

    #########################################################
    # git/heroku setup
    #########################################################
    def git_init
      run 'git init'
    end

    def create_github_repo(repo_name)
      path_addition = override_path_for_tests
      run "#{path_addition} hub create #{repo_name}"
    end

    def create_heroku_apps
      run_heroku "create #{heroku_app_name :production}", "production"
      run_heroku "create #{heroku_app_name :staging}", "staging"
      run_heroku "config:add RACK_ENV=staging RAILS_ENV=staging", "staging"
    end

    def set_heroku_remotes
      remotes = <<-SHELL

# Set up the staging and production apps.
#{join_heroku_app :staging}
#{join_heroku_app :production}
      SHELL

      append_file "bin/setup", remotes
    end

    def set_heroku_env_variables
      config = <<-SHELL
# Sets Heroku env variables
figaro heroku:set -a #{heroku_app_name :production} -e production
figaro heroku:set -a #{heroku_app_name :staging} -e production
      SHELL
      append_file "bin/setup", config
    end

    def add_heroku_addons
      config = <<-SHELL

# Heroku addons for production
heroku addons:add mandrill --app #{heroku_app_name :production}
heroku addons:add newrelic:stark --app #{heroku_app_name :production}
heroku addons:add rollbar --app #{heroku_app_name :production}
      SHELL
      append_file "bin/setup", config
    end

    def set_memory_management_variable
      %w(staging production).each do |environment|
        run_heroku "config:add NEW_RELIC_AGGRESSIVE_KEEPALIVE=1", environment
      end
    end

    #########################################################
    # Helper methods
    #########################################################
    private

    def raise_on_missing_translations_in(environment)
      config = "config.action_view.raise_on_missing_translations = true"

      uncomment_lines("config/environments/#{environment}.rb", config)
    end

    def run_heroku(command, environment)
      path_addition = override_path_for_tests
      run "#{path_addition} heroku #{command} --remote #{environment}"
    end

    def heroku_app_name(environment)
      "#{app_name.gsub '_', '-'}-#{environment}"
    end

    def join_heroku_app(environment)
      name = heroku_app_name environment
      <<-SHELL
if heroku join --app #{name} &> /dev/null; then
  git remote add #{environment} git@heroku.com:#{name}.git || true
  printf 'You are a collaborator on the "#{name}" Heroku app\n'
else
  printf 'Ask for access to the "#{name}" Heroku app\n'
fi
      SHELL
    end

    def generate_secret
      SecureRandom.hex(64)
    end

    def override_path_for_tests
      if ENV['TESTING']
        support_bin = File.expand_path(File.join('..', '..', 'spec', 'fakes', 'bin'))
        "PATH=#{support_bin}:$PATH"
      end
    end
  end
end
