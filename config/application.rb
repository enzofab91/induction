require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Induction
  class Application < Rails::Application
    config.load_defaults 6.1

    ActionMailer::Base.smtp_settings = {
      address: 'smtp.sendgrid.net',
      port: 25,
      domain: 'www.api.com',
      authentication: :plain,
      user_name: ENV['SENDGRID_USERNAME'],
      password: ENV['SENDGRID_PASSWORD']
    }

    config.action_mailer.default_url_options = { host: ENV['SERVER_URL'] }
    config.action_mailer.default_options = {
      from: 'no-reply@api.com'
    }
  end
end
