# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'spec_helper'
require 'rspec/rails'

abort("The Rails environment is running in production mode!") if Rails.env.production?

ActiveRecord::Migration.maintain_test_schema!

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include ActiveSupport::Testing::TimeHelpers

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.after { ActiveRecord::Base.clear_active_connections! }

  if ENV['RSPEC_RETRY'] == 'true'
    puts 'With RSpec retry'
    # show retry status in spec process
    config.verbose_retry = true

    # show exception that triggers a retry if verbose_retry is set to true
    config.display_try_failure_messages = true

    # run retry only on features
    config.around :each, :js do |ex|
      ex.run_with_retry retry: 3
    end
  end

  config.before(:suite) do
    Webpacker.compile
  end
end
