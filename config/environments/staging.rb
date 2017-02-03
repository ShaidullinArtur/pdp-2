require_relative "production"

Rails.application.configure do
  config.force_ssl = true
  config.webpack.dev_server.enabled = false

  ActionMailer::Base.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    user_name: "09c79dfed55141",
    password: "6880cc8c2744ad",
    address: "smtp.mailtrap.io",
    domain: "smtp.mailtrap.io",
    port: "2525",
    authentication: :cram_md5
  }
end
