require "rails/generators"
require "rails/generators/rails/app/app_generator"

module Bluebase_api
  class AppGenerator < Rails::Generators::AppGenerator
    class_option :database, type: :string, aliases: "-d", default: "postgresql",
      desc: "Preconfigure for selected database (options: #{DATABASES.join('/')})"

    class_option :heroku, type: :boolean, aliases: "-H", default: false,
      desc: "Create staging and production Heroku apps"

    class_option :skip_git, type: :boolean, default: false, desc: "Skip git init"

    class_option :skip_bundle, type: :boolean, default: true, desc: "Don't run bundle install"

    class_option :github, type: :string, aliases: "-G", default: nil,
      desc: "Create Github repository and add remote origin pointed to repo"

    class_option :skip_test_unit, type: :boolean, aliases: "-T", default: true,
      desc: "Skip Test::Unit files"

    # Invoked after Rails generates app
    def finish_template
      invoke :bluebase_api_customization
      super
    end

    def bluebase_api_customization
      invoke :customize_root_files
      invoke :customize_bin_files
      invoke :customize_config_files
      invoke :customize_spec_files
      invoke :setup_git_and_github
      invoke :setup_heroku_apps
      invoke :outro
      invoke :customize_app_directory
      invoke :customize_public_directory
      invoke :customize_vendor_directory
      invoke :customize_lib_directory
      invoke :customize_tmp_directory
    end

    def customize_root_files
      build :replace_gemfile
      build :add_envrc
      build :replace_gitignore
      build :add_rubocop_and_hound_config
      build :add_rvm_config
      build :add_guardfile
      build :add_dot_rspec
    end

    def customize_bin_files
      # Rails 4.2.0 comes with a setup script by default
      # build :add_setup_to_bin
    end

    def customize_config_files
      build :configure_application_environment
      build :configure_development_environment
      build :configure_test_environment
      build :configure_production_environment
      build :add_staging_environment
      build :add_devise_config
      build :add_figaro_config
      build :replace_en_yml
      build :add_application_yml
      build :add_database_yml if options[:database] == 'postgresql'
      build :add_i18n_tasks_yml
      build :replace_secrets_yml
      build :add_smtp_settings
      build :replace_routes_rb # Added by Quinton and Tricia
    end

    def customize_spec_files
      build :add_spec_dirs
      build :configure_rspec
      build :configure_factorygirl
      build :configure_actionmailer
      build :configure_i18n
      build :configure_database_cleaner
    end

    def customize_lib_directory # Added by Quinton and Tricia
      build :remove_lib_assets_directory
    end

    def customize_app_directory # Added by Quinton and Tricia
      build :configure_api_directory
      build :configure_v1_directory
      build :add_base_controller
      build :replace_application_controller
      build :add_serializers_directory
      build :remove_app_assets_directory
      build :remove_app_views_directory
    end

    def customize_public_directory # Added by Quinton and Tricia
      build :remove_html_files
    end

    def customize_vendor_directory # Added by Quinton and Tricia
      build :remove_vendor_assets_directories
    end

    def customize_tmp_directory # Added by Quinton and Tricia
      build :remove_tmp_assets_directory
    end

    def setup_git_and_github
      if !options[:skip_git]
        say "Initializing git"
        build :git_init
        if options[:github]
          say "Creating github repo"
          build :create_github_repo, options[:github]
        end
      end
    end

    def setup_heroku_apps
      if options[:heroku]
        say "Creating heroku apps"
        build :create_heroku_apps
        build :set_heroku_remotes
        build :set_heroku_env_variables
        build :add_heroku_addons
        build :set_memory_management_variable
      end
    end

    def outro
      say "Your bluebase_api is complete!"
      say "Remember to set:"
      say "- Your database settings in config/database.yml"
      say "- Your env variables in config/application.yml"
      say "- Your Code Climate token in .travis.yml"
      say "Afterward, you can now run bin/setup in your project directory to set up the app."
    end

    def run_bundle
      # We'll run it ourselves
    end

    private

    def get_builder_class
      Bluebase_api::AppBuilder
    end
  end
end
