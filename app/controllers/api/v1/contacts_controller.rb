module Api
  module V1
    class ContactsController < Api::V1::ApiController
      skip_before_action :authenticate_user!

      def create
        contact = Contact.create!(contacts_params)
        AdminMailer.new_contact_question(contact)
        head :ok
      end

      private

      def contacts_params
        params.require(:contact).permit(:body, :email)
      end
    end
  end
end
