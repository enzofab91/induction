module Api
  module V1
    class ConfirmationsController < Devise::ConfirmationsController
      protect_from_forgery with: :null_session
      include Api::Concerns::ActAsApiRequest
      respond_to :json

      private

      def configure_permitted_parameters
        params.permit(:confirmation_token, :confirmation)
      end
    end
  end
end
