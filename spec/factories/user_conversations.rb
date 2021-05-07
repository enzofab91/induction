# == Schema Information
#
# Table name: user_conversations
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_user_conversations_on_conversation_id  (conversation_id)
#  index_user_conversations_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (conversation_id => conversations.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :user_conversation do
    user
    match
  end
end
