require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

Capybara.register_driver :selenium do |app|
  options = Selenium::WebDriver::Chrome::Options.new(args: %w[no-sandbox headless disable-gpu])
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :selenium_chrome_headless

Capybara.configure do |config|
  config.default_max_wait_time = 5
end

SimpleCov.start "rails"

Shoulda::Matchers.configure do |config|
    config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end

def stub_omniauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({ 'provider' => 'github',
                                                              'info' => { 'name' => 'Scooby Doo' },
                                                              'credentials' =>
                                                                { 'token' => ENV["github_api_token_c"],
                                                                  'expires' => false },
                                                              'extra' =>
                                                                { 'raw_info' =>
                                                                  { 'login' => 'scooby_snacks',
                                                                    'html_url' => 'https://github.com/cgaddis36',
                                                                    'name' => 'Scooby Doo' } } })

end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data('<gihub_api_token_c>') { ENV['github_api_token_c'] }
  config.filter_sensitive_data('<gihub_api_token_k>') { ENV['github_api_token_k'] }
  config.filter_sensitive_data('<github_client_id>') { ENV['github_client_id'] }
  config.filter_sensitive_data('<github_client_secret>') { ENV['github_client_secret'] }
  config.configure_rspec_metadata!
end
