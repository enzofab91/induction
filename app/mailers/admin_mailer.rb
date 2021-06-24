class AdminMailer < ApplicationMailer
  DEFAULT_ADMIN_EMAIL = 'no_reply@target.com'.freeze

  def new_contact_question(contact)
    @contact = contact
    mail(to: @contact.email,
         from: DEFAULT_ADMIN_EMAIL,
         subject: I18n.t('mailer.admin.new_question'))
  end
end
