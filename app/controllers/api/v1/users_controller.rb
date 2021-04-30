module Api
  module V1
    class UsersController < Api::V1::ApiController
      def show; end

      def update
        current_user.update!(user_params)
        render :show
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :gender)
      end
    end
  end
end
