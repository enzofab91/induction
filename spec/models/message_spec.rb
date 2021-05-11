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
describe Message, type: :model do
  subject(:message) { build :message }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:body) }
  end

  describe 'associations' do
    it { should belong_to(:conversation) }
    it { should belong_to(:user) }
  end
end
