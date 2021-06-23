class AdminMailer < ApplicationMailer
  def new_contact_question(contact)
    from = 'no_reply@target.com'

    @contact = contact
    mail(to: @contact.email,
         from: from,
         subject: I18n.t('mailer.admin.new_question'))
  end
end
