module Api
  module V1
    class ConversationsController < Api::V1::ApiController
      def index
        @conversations = current_user.conversations
      end

      # def messages
      #   binding.pry
      #   @messages = Conversation.find(params[:conversation_id]).messages.page(page)
      # end

      private

      def page
        params[:page] || 1
      end
    end
  end
end
