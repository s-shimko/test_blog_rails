require 'cucumber/rails'
require 'capybara'
require 'capybara/cucumber'
require 'capybara-webkit'

require 'selenium-webdriver'
require 'rspec'
require 'rspec/expectations'

require 'capybara-screenshot'
require 'capybara-screenshot/cucumber'

$GLOBAL_HASH = {}

ActionController::Base.allow_rescue = false

# Remove/comment out the lines below if your app doesn't have a database.
# For some databases (like MongoDB and CouchDB) you may need to use :truncation instead.
begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

# Possible values are :truncation and :transaction
# The :transaction strategy is faster, but might give you threading problems.
# See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
Cucumber::Rails::Database.javascript_strategy = :truncation

# --------Headless-webkit-driver--------
Capybara.default_driver = :webkit

Capybara.default_max_wait_time = 0
Capybara.ignore_hidden_elements = true
Capybara.visible_text_only = true
Capybara.automatic_reload = false

Capybara::Webkit.configure do |config|
  config.debug = false
  config.timeout = 60
  config.allow_unknown_urls
end

#------------capybara-webkit screenshots---------------
After do |scenario|
  if Capybara::Screenshot.autosave_on_failure && scenario.failed?
    Capybara.save_path = "features/reports"
    Capybara::Screenshot.class_eval do
      register_filename_prefix_formatter(:default) do
        "#{scenario.name}"
      end
    end
  end
end

# # ------------Browser-mode----------
# Capybara.configure  do |capybara|
#   Capybara.default_max_wait_time = 0
#
#   #
#   Capybara.register_driver :selenium_ff do |app|
#
#     client = Selenium::WebDriver::Remote::Http::Default.new
#     client.timeout = 60
#
#     Capybara::Selenium::Driver.new(app, :browser => :firefox, :http_client => client,
#                                    desired_capabilities: {
#                                        "ffOptions" => {
#                                            "args" => %w{ window-size=1580,1024 }
#                                        }
#                                    }
#     )
#   end
#
#   capybara.default_driver = :selenium_ff
#   capybara.run_server = false
#
# end


