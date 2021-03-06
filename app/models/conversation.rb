# == Schema Information
#
# Table name: conversations
#
#  id                          :bigint           not null, primary key
#  first_user_unread_messages  :integer          default(0)
#  second_user_unread_messages :integer          default(0)
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  match_id                    :bigint           not null
#
# Indexes
#
#  index_conversations_on_match_id  (match_id)
#
# Foreign Keys
#
#  fk_rails_...  (match_id => matches.id)
#
class Conversation < ApplicationRecord
  belongs_to :match

  has_many :user_conversations, dependent: :destroy
  has_many :users, through: :user_conversations
  has_many :messages, dependent: :destroy

  after_create :add_users_to_conversation

  validate :users_uniqueness, on: :create

  def recipient_user(user)
    users.where.not(id: user.id)&.first
  end

  def mark_messages_as_read(user)
    if first?(user)
      update!(first_user_unread_messages: 0)
    else
      update!(second_user_unread_messages: 0)
    end
  end

  def new_messages_count(user)
    first?(user) ? first_user_unread_messages : second_user_unread_messages
  end

  def increase_unread(user)
    if first?(user)
      update!(first_user_unread_messages: first_user_unread_messages + 1)
    else
      update!(second_user_unread_messages: second_user_unread_messages + 1)
    end
  end

  private

  def add_users_to_conversation
    users << [match.first_user, match.second_user]
  end

  def first?(user)
    match.first_user == user
  end

  def users_uniqueness
    first_user_conversations = UserConversation.where(user_id: match.first_user_id)
                                               .pluck(:conversation_id)
    second_user_conversations = UserConversation.where(user_id: match.second_user_id)
                                                .pluck(:conversation_id)

    # if both conversations intersections match means already exist a conversation between them
    return if (first_user_conversations & second_user_conversations).empty?

    errors.add(:conversations, I18n.t('api.errors.uniqueness_conversation'))
  end
end
