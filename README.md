Vignetto 1.0
================
This application requires:
- Ruby 2.2.2
- Rails 4.2.1

Getting Started
---------------
* Install homebrew on mac (http://brew.sh/)
* Install rvm (http://rvm.io)
* Install ruby 2.2.2
* Install foreman (https://github.com/ddollar/foreman)
* Install other brew packages
	* __brew install postgresql__ (don't set up autostart, using 9.3+)

Configuration
--------------
* Create local .env (from .env.sample)
* Create local database.yml (from database.yml.sample)
* Create local Procfile.dev (from Procfile.dev.sample)
* Create local secrets.yml (from secrets.yml.sample)
  * Get AWS Dev credentials from Slack and update in secrets.yml
  * Alternatively, set environment variable DEV_USE_LOCAL to any value

Start Vignetto Application
----------------------
* Run `bundle` (run only once, unless Gemfile is updated)
* Run `rake db:create db:migrate db:seed`
* Start the various background processes (DB, server)
* Run `foreman start -f Procfile.dev -e .env` (for development env)
* Run `rails s` (to start WEBrick)
