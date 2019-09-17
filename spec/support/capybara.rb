require 'capybara/rspec'
require 'capybara/rails'
require 'rack/utils'
require 'selenium/webdriver'

require 'capybara-screenshot/rspec'

Capybara.register_driver(:chrome) do |app|
  chrome_args = %w[window-size=1600,768]
  chrome_args += %w[headless disable-gpu] unless ENV['TEST_CARTOON']

  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: chrome_args }
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities
  )
end

Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end

Capybara.javascript_driver = :chrome

Capybara.save_path = Rails.root.join('tmp', 'capybara')
Capybara::Screenshot.autosave_on_failure = true
Capybara::Screenshot.prune_strategy = :keep_last_run

def screenshot
  Capybara::Screenshot.screenshot_and_open_image
end
