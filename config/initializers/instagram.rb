Instagram.configure do |config|
  config.client_id = Rails.application.secrets.client_id
  config.client_secret = Rails.application.secrets.client_secret
  config.redirect_uri = CGI.unescape(Rails.application.secrets.redirect_uri)
end
