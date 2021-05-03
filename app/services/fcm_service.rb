class FcmService
  def self.sent_notification(registration_ids, title, data)
    fcm = FCM.new(ENV['SENDGRID_USERNAME'])

    # See https://firebase.google.com/docs/cloud-messaging/http-server-ref for all available options.
    options = {
      notification: {
        title: title,
        body: data
      }
    }

    fcm.send(registration_ids, options)
  end
end
