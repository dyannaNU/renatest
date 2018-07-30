require "raven"
require "yadlapati"

Raven.configure do |config|
  config.environments = %w( staging production )
  config.excluded_exceptions = %w(
    ActionController::UnknownHttpMethod
  )
  dsn = Rails.application.config.try(:sentry_dsn)
  config.dsn = dsn if dsn
  config.release = Yadlapati::VERSION
end
