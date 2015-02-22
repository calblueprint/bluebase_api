# rails-API-gem
Blueprint's base app with API functionality (under development)


--
Notes:


Rails API gem
Working 
Understanding Base App
Make a Rails App
Make a map and figure out what the gem will output
Modify the bluebase app outputs the right thing
Push it to ruby gems
make the rails app
use curl to test
dive into blue base code and understand what everything is doing (ask sam)
modify the template files so they output the right things


By next week: 
-- Make a rails Application
-- understanding bluebase
-- start a rails app from scratch 
-- and use bluebase for the gem structure


-- application controller
-- remove views
-- change gems
-- structure of the folder (see watershed
-- setup authentication for the api
-- serializers: a way to render json in a nice way → if we have a model, then this is what the json rendition of the model will look like
-- active-model serializers (user auth)
-- bluebase: config is pretty standard (staging, configure, copy over) 
-- database: same database.yml, and schema seeds


GEM
-- go into gemspec and meta data
-- lib: every file is included → required all the other files
-- how to ruby gem
-- app_generator.rb: overrides default generator (default to postgres for database)
-- finish_template: when rails new finishes running; invoke :bluebase_customization; super
-- app_generator calls app_builder (in the tempaltes folder)

-- mostly copying
