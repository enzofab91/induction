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
FactoryBot.define do
  factory :conversation do
    match
  end
end
