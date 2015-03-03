require 'spec_helper'

feature 'Heroku' do
  scenario 'Initialize a project with --heroku=true' do
    run_bluebase('--heroku=true')

    expect(FakeHeroku).to have_gem_included(project_path, 'rails_12factor')
    expect(FakeHeroku).to have_created_app_for('staging')
    expect(FakeHeroku).to have_created_app_for('production')

    bin_setup = IO.read("#{project_path}/bin/setup")
    app_name = BluebaseTestHelpers::APP_NAME

    expect(bin_setup).to include("figaro heroku:set -a #{app_name}-production -e production")
    expect(bin_setup).to include("figaro heroku:set -a #{app_name}-staging -e production")

    expect(bin_setup).to include("heroku join --app #{app_name}-staging")
    expect(bin_setup).to include("heroku join --app #{app_name}-production")

    expect(bin_setup).to include("heroku addons:add mandrill --app #{app_name}-production")
    expect(bin_setup).to include("heroku addons:add newrelic:stark --app #{app_name}-production")
    expect(bin_setup).to include("heroku addons:add rollbar --app #{app_name}-production")
  end
end
