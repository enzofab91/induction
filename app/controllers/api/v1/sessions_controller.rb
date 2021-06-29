module Api
  module V1
    class SessionsController < DeviseTokenAuth::SessionsController
      protect_from_forgery with: :null_session
      include Api::Concerns::ActAsApiRequest

      def facebook
        user_params = FacebookService.new(params[:access_token]).profile
        @resource = User.from_social_provider('facebook', user_params)
        provider_sign_in
      rescue Koala::Facebook::AuthenticationError
        render json: { error: I18n.t('api.errors.facebook_not_authorized') }, status: :forbidden
      rescue ActiveRecord::RecordNotUnique
        render json: { error: I18n.t('facebook_user_exists') }, status: :bad_request
      end

      private

      def resource_params
        params.require(:user).permit(:email, :password)
      end

      def render_create_success
        render json: { user: resource_data }
      end

      def provider_sign_in
        sign_in(:api_v1_user, @resource)
        response.headers.merge!(@resource.create_new_auth_token)
        render_create_success
      end
    end
  end
end
