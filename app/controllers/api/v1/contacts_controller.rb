module Api
  module V1
    class ContactsController < Api::V1::ApiController
      skip_before_action :authenticate_user!

      def create
        Contact.create!(contacts_params)
        head :ok
      end

      private

      def contacts_params
        params.require(:contact).permit(:body, :email)
      end
    end
  end
end
