# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  body            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (conversation_id => conversations.id)
#  fk_rails_...  (user_id => users.id)
#
class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :body, presence: true

  after_create_commit :broadcast_message
  after_create_commit :notify_user

  paginates_per 10

  private

  def broadcast_message
    ConversationChannel.broadcast_to(conversation, render_body(body))
    conversation.increase_unread(user)
  end

  def render_body(body)
    {
      body: body
    }
  end

  def notify_user
    return unless receiver_push_token.present?

    FcmService.sent_notification([receiver_push_token], I18n.t('api.notifications.new_message'), body)
  end

  def receiver_push_token
    conversation.recipient_user(user).push_token
  end
end
