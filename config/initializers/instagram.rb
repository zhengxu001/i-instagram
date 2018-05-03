Instagram.configure do |config|
  config.client_id = '7b5b197214584d648db946e68b79c094'
  config.client_secret = '8b5772632f5b44d9b925be38e1bffb88'
  config.redirect_uri = CGI::unescape('http://213.233.150.101:4567/oauth/callback')
end

p 'test'