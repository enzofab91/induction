module Api
  module V1
    class MessagesController < Api::V1::ApiController
      def index
        @messages = conversation.messages.page(page)
        conversation.mark_messages_as_read(current_user)
      end

      private

      def conversation
        @conversation ||= current_user.conversations.find(params[:conversation_id])
      end

      def page
        params[:page] || 1
      end
    end
  end
end
