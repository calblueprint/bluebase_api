require 'spec_helper'

feature 'Initialize a new project with default configuration' do
  # TODO: Write comprehensive specs
  before { run_bluebase }

  scenario 'staging config is inherited from production' do
    staging_file = IO.read("#{project_path}/config/environments/staging.rb")
    config_stub = "Rails.application.configure do"

    expect(staging_file).to match(/^require_relative "production"/)
    expect(staging_file).to match(/#{config_stub}/), staging_file
  end

  scenario 'generated .ruby-version is pulled from Bluebase .ruby-version' do
    ruby_version_file = IO.read("#{project_path}/.ruby-version")

    expect(ruby_version_file).to eq "#{RUBY_VERSION}\n"
  end

  scenario 'secrets.yml reads secret from env' do
    secrets_file = IO.read("#{project_path}/config/secrets.yml")

    expect(secrets_file).to match(/secret_key_base: <%= ENV\["SECRET_KEY_BASE"\] %>/)
  end

  scenario 'action mailer support file is added' do
    expect(File).to exist("#{project_path}/spec/support/action_mailer.rb")
  end

  scenario "i18n support file is added" do
    expect(File).to exist("#{project_path}/spec/support/i18n.rb")
  end

  scenario "raises on unpermitted parameters in all environments" do
    result = IO.read("#{project_path}/config/application.rb")

    expect(result).to match(
      /^ +config.action_controller.action_on_unpermitted_parameters = :raise$/
    )
  end

  scenario "raises on missing translations in development and test" do
    %w[development test].each do |environment|
      environment_file =
        IO.read("#{project_path}/config/environments/#{environment}.rb")
      expect(environment_file).to match(
        /^ +config.action_view.raise_on_missing_translations = true$/
      )
    end
  end

  scenario "specs for missing or unused translations" do
    bin_setup = IO.read("#{project_path}/bin/setup")
    expect(bin_setup).to include("cp $(i18n-tasks gem-path)/templates/rspec/i18n_spec.rb spec/")
  end

  scenario "config file for i18n tasks" do
    expect(File).to exist("#{project_path}/config/i18n-tasks.yml")
  end

  scenario "generated en.yml is evaluated" do
    locales_en_file = IO.read("#{project_path}/config/locales/en.yml")
    app_name = BluebaseTestHelpers::APP_NAME

    expect(locales_en_file).to match(/application: #{app_name.humanize}/)
  end
end
