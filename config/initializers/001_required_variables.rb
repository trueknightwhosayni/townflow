return if ENV["SKIP_VARS_CHECKING"].present?

required = %w(
  CURRENT_HOST
)

if %w(development test).include?(Rails.env)
  required += %w(
    DB_HOST
    DB_NAME
  )
end

if %w(production release staging).include?(Rails.env)
  required += %w(
    DATABASE_URL
  )
end

errors  = []

# handle strictly required variables
missing = required.reject { |e| ENV.key?(e) }
errors.push "Following environment variables required but not set: #{missing.join(', ')}" unless missing.empty?

raise errors.join("\n") unless errors.empty?
