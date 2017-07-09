<img width="350" src="https://user-images.githubusercontent.com/15371677/27876034-6f54c860-61f0-11e7-8ebb-0623227ee491.png">

[![Build Status](https://travis-ci.org/yhirano55/genkan.svg?branch=master)](https://travis-ci.org/yhirano55/genkan)
[![Gem Version](https://badge.fury.io/rb/genkan.svg)](https://badge.fury.io/rb/genkan)

Genkan is authentication engine for Rails

## Installation

```ruby
gem 'genkan'

# Add any omniauth provider
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'
```

And then execute:

```bash
$ bundle
```

## Getting started

```bash
$ bin/rails g genkan:install --model User
      create  config/initializers/genkan.rb
      create  db/migrate/20170705074103_create_users.rb
      create  app/models/user.rb
      insert  app/controllers/application_controller.rb
       route  mount Genkan::Engine, at: '/'
      create  app/views/genkan/sessions/new.html.erb

$ bin/rails db:migrate
```

Some setup you must do manually if you haven't yet:

1. Ensure you have edited config/initializers/genkan.rb.
   For example:

  ```ruby
  Genkan.configure do |config|
    config.user_class_name   = 'User'
    config.auto_acceptance   = true
    config.cookie_expiration = 1.week
  end

  Genkan::Engine.configure do |config|
    config.middleware.use OmniAuth::Builder do
      # Add omniauth-google-oauth2 to Gemfile:
      #   gem 'omniauth-google-oauth2'
      provider(
        :google_oauth2,
        ENV['GOOGLE_OAUTH_CLIENT_ID'],
        ENV['GOOGLE_OAUTH_CLIENT_SECRET'],
        {
          name:  'google',
          scope: 'email',
          hd:    'host-domain.com'
        }
      )
    end
  end
  ```

2. Ensure you have defined root_url to *something* in your config/routes.rb.
   For example:

  ```ruby
  root to: "home#index"
  ```

3. Ensure you have flash messages in app/views/layouts/application.html.erb.
   For example:

  ```ruby
  <p class="notice"><%= notice %></p>
  <p class="alert"><%= alert %></p>
  ```

4. Ensure you have set logout link in app/views/layouts/application.html.erb.
   For example:

  ```ruby
  <% if logged_in? %>
    <p><%= link_to "logout", genkan.logout_path %></p>
  <% end %>
  ```

## Debugging

You can check on dummy server:

```bash
$ bundle
$ bin/rails db:setup
$ GOOGLE_OAUTH_CLIENT_ID=YOUR_ID GOOGLE_OAUTH_CLIENT_SECRET=YOUR_SECRET bin/rails s
```

How to create google client id and secret:

- [Creating a Google API Console project and client ID  |  Google Sign-In for Websites  |  Google Developers](https://developers.google.com/identity/sign-in/web/devconsole-project).

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
