# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  match_id   :bigint           not null
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

  private

  def add_users_to_conversation
    users << [match.first_user, match.second_user]
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
