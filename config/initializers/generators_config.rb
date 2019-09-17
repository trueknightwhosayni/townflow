Rails.application.config.generators do |g|
  g.orm :active_record
  g.test_framework = :rspec
end