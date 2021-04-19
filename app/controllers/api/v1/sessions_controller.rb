module Api
  module V1
    class SessionsController < DeviseTokenAuth::SessionsController
      protect_from_forgery with: :null_session
      include Api::Concerns::ActAsApiRequest
      include Api::Concerns::SetUserByToken

      def resource_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
