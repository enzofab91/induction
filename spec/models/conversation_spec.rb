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
describe Conversation, type: :model do
  describe 'validations' do
    let(:target) { create(:target) }
    let(:first_user) { create(:user) }
    let(:second_user) { create(:user) }
    let(:match) { build(:match, first_user_id: first_user.id, second_user_id: second_user.id, target_id: target.id) }
    let!(:conversations) { create_list(:conversation, 1, match: match) }
    let(:conversation) { build :conversation, match: match }

    context 'when an existing conversation between two users wants to be created' do
      it 'is not valid' do
        expect(conversation).to_not be_valid
      end

      it 'returns error message' do
        conversation.valid?
        expect(conversation.errors[:conversations]).to include I18n.t('api.errors.uniqueness_conversation')
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:match) }
    it { should have_many(:user_conversations) }
    it { should have_many(:users) }
  end
end
