module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      protect_from_forgery with: :exception
      include Api::Concerns::ActAsApiRequest

      private

      def sign_up_params
        params.require(:user).permit(:email, :gender, :password, :password_confirmation)
      end

      def render_create_success
        render json: { user: resource_data }
      end
    end
  end
end
