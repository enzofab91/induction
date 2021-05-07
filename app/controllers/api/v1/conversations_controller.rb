module Api
  module V1
    class ConversationsController < Api::V1::ApiController
      def index
        @conversations = current_user.conversations
      end
    end
  end
end
