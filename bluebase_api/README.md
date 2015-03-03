# Bluebase

The base app for Blueprint's Rails apps.

## Features

Core gems:
- [Thin](https://github.com/macournoyer/thin/) for the server
- [Postgres](https://rubygems.org/gems/pg) to use postgres as the database
- [Figaro](https://github.com/laserlemon/figaro) for environment variables

Component gems:
- [Devise](https://github.com/plataformatec/devise) for user auth
- [Simple Form](https://github.com/plataformatec/simple_form) for easier forms
- [Gon](https://github.com/gazay/gon) to push data to javascript
- [Kaminari](https://github.com/amatsuda/kaminari) for pagination
- [Recipient Interceptor](https://github.com/croaky/recipient_interceptor) to stop email sending from staging

Frontend gems:
- [Slim](https://github.com/slim-template/slim-rails) to use the [Slim](http://slim-lang.com/) templating language
- [Autoprefixer](https://github.com/ai/autoprefixer-rails) to autogenerate vendor prefixes
- [Flutie](https://github.com/thoughtbot/flutie) for the ```body_class``` view helper
- [Title](https://github.com/calebthompson/title) for page titles in I18n

Development gems:
- [Annotate](https://github.com/ctran/annotate_models) to annotate models
- [FFaker](https://github.com/EmmanuelOga/ffaker) to generate random data
- [Better Errors](https://github.com/charliesome/better_errors) + [Binding of Caller](https://github.com/banister/binding_of_caller) for useful error pages
- [Quiet Assets](https://github.com/evrone/quiet_assets) to quiet asset rending output in the server
- [Spring](https://github.com/rails/spring) for fast commands
- [Rubocop](https://github.com/bbatsov/rubocop) for Rails linting
- [I18n Tasks](https://github.com/glebm/i18n-tasks) to lint translation files
- [Awesome Print](https://github.com/michaeldv/awesome_print) for better console object printing
- [Guard](https://github.com/guard/guard) to run tasks on file changes
- [Pry](https://github.com/pry/pry) and [Pry Byebug](https://github.com/deivid-rodriguez/pry-byebug) to explore objects and debug

Test gems:
- [RSpec](https://github.com/rspec/rspec-rails) for specs
- [Capybara](https://github.com/jnicklas/capybara) for integration tests
- [FactoryGirl](https://github.com/thoughtbot/factory_girl) for test data
- [Shoulda Matchers](https://github.com/thoughtbot/shoulda) for common RSpec matchers
- Launchy to use ```save_and_open_page``` in Capybara
- [Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner) to clear the database for specs
- [CodeClimate Test Reporter](https://github.com/codeclimate/ruby-test-reporter) to track test coverage

Production gems/features (most of these require setup):
- New Relic for monitoring performance
- Rollbar for error logging
- Rails 12Factor for Heroku

Other features:
- Staging environment config
- Email config using SMTP
- The ```./bin/setup``` convention for new developer setup
- Rails' flashes set up and in application layout
- Configuration for Rubocop/[Hound](https://houndci.com/)
- A Guardfile set up with [Livereload](https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei?hl=en), RSpec, and Rubocop
- A few nice time formats set up for localization
- ```Rack::Deflater``` to compress responses with Gzip
- A low database connection pool limit
- ```t()``` and ```l()``` in specs without prefixing with I18n
- An automatically-created ```SECRET_KEY_BASE``` environment variable in all environments.
- Configuration for Travis continuous integration.
- Config for Google Analytics

## Installation

Run

    gem install bluebase

Then you can run

    bluebase app_name

To create an app called ```app_name```. Optionally append ```-G repo_name``` and ```-H``` to create a Github repo and staging + production Heroku apps, respectively.

## Contributing

Feel free to open issues or send pull requests with improvements. Thanks in
advance for your help!

## Cal Blueprint
![bp](http://bptech.berkeley.edu/assets/logo-full-large-d6419503b443e360bc6c404a16417583.png "BP Banner")
**[Cal Blueprint](http://www.calblueprint.org/)** is a student-run UC Berkeley organization devoted to matching the skills of its members to our desire to see social good enacted in our community. Each semester, teams of 4-5 students work closely with a non-profit to bring technological solutions to the problems they face every day.

## Credits
Bluebase is a fork of thoughtbot's [suspenders](https://github.com/thoughtbot/suspenders)

## License

Bluebase is Copyright © 2014 Cal Blueprint. It is free software, and may be redistributed under the terms
specified in the LICENSE.txt file.
