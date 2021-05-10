module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def suscribed
      conversation = current_user.conversations.find_by(id: params[:conversation_id])
      stream_for conversation
    end
  end
end
