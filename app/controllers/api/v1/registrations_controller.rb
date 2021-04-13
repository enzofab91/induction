module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      protect_from_forgery with: :exception
      include Api::Concerns::ActAsApiRequest

      before_action :authenticate_user!, except: :create

      private

      def sign_up_params
        params.require(:user).permit(:email, :gender, :password, :password_confirmation)
      end
    end
  end
end
