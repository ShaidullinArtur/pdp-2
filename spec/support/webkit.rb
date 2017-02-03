Capybara::Webkit.configure do |config|
  config.allow_url("*.lvh.me")
  config.block_url("google-analytics.com")
end
