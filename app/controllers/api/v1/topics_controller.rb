module Api
  module V1
    class TopicsController < ApplicationController
      include Concerns::ActAsApiRequest
      include DeviseTokenAuth::Concerns::SetUserByToken

      before_action :authenticate_user!

      def index
        @topics = Topic.all
      end
    end
  end
end
