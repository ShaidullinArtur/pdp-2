require_relative "production"

Rails.application.configure do
  config.force_ssl = true
  config.webpack.dev_server.enabled = false
end
