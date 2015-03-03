require 'spec_helper'

feature 'GitHub' do
  scenario 'Initialize a project with --github option' do
    repo_name = 'test'
    run_bluebase("--github=#{repo_name}")

    expect(FakeGithub).to have_created_repo(repo_name)
  end
end
