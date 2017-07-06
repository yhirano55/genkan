require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include ::Rails::Controller::Testing::TestProcess,        type: :controller
  config.include ::Rails::Controller::Testing::TemplateAssertions, type: :controller
  config.include ::Rails::Controller::Testing::Integration,        type: :controller

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:suite) do
    FactoryGirl.reload
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

FactoryGirl.definition_file_paths << "#{File.dirname(__FILE__)}/factories"

OmniAuth.config.test_mode = true

def stub_omniauth(email: Faker::Internet.email)
  OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new(
    "provider" => "google", "info" => { "email" => email }
  )
end
