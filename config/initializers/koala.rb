Koala.configure do |config|
  config.access_token = ENV['FACEBOOK_TOKEN']
  config.app_access_token = ENV['FACEBOOK_APP_TOKEN']
  config.app_id = ENV['FACEBOOK_APP_ID']
  config.app_secret = ENV['FACEBOOK_APP_SECRET']
end
