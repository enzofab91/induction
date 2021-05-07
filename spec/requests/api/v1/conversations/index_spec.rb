describe 'GET api/v1/conversations', type: :request do
  let(:target) { create :target }
  let(:user) { create :user }
  let(:second_user) { create :user }
  let(:match) { build(:match, first_user_id: user.id, second_user_id: second_user.id, target_id: target.id) }
  let!(:conversations) { create_list :conversation, 1, match: match }
  let!(:other_user_conversations) { create_list :conversation, 2 }

  subject { get api_v1_conversations_path, headers: auth_headers, as: :json }

  it 'returns a successful response' do
    subject
    expect(response).to be_successful
  end

  it 'returns user conversations' do
    subject
    expect(json[:conversations].pluck([:id])).to match_array(conversations.pluck([:id]))
  end

  it 'does not return other\'s users conversations' do
    subject
    expect(json[:conversations].pluck([:id])).not_to include(other_user_conversations.pluck([:id]))
  end
end
