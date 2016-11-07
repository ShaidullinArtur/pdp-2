require_relative "production"

Rails.application.configure do
  config.force_ssl = false
  config.webpack.dev_server.enabled = false
end
