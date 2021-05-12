class ConversationChannel < ApplicationCable::Channel
  def suscribed
    conversation = current_user.conversations.find_by(id: params[:conversation_id])
    stream_for conversation
  end

  def send_message(data)
    Message.create(
      conversation_id: data['conversation_id'],
      user_id: data['user_id'],
      body: data['body']
    )
  end
end
