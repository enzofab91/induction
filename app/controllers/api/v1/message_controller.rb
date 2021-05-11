module Api
  module V1
    class MessagesController < Api::V1::ApiController
      def index
        @messages = current_user.conversations.find(params[:conversation_id])
      end
    end
  end
end
