describe 'GET api/v1/conversations/{id}/messages', type: :request do
  let(:user) { create(:user) }
  let(:second_user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:match) { create(:match, first_user: user, second_user: second_user) }
  let(:other_match) { create(:match, first_user: user, second_user: other_user) }
  let(:conversation) { create(:conversation, users: [user, second_user], match: match, first_user_unread_messages: 3) }
  let!(:messages) do
    create_list(:message, 3, user: user, conversation: conversation)
  end
  let(:other_conversation) { create(:conversation, users: [user, second_user], match: other_match) }
  let!(:other_conversation_messages) do
    create_list(:message, 3, user: user, conversation: other_conversation)
  end

  subject { get api_v1_conversation_messages_path(conversation.id), headers: auth_headers, as: :json }

  before do
    subject
  end

  it 'returns a successful response' do
    expect(response).to be_successful
  end

  it 'returns the messages' do
    expect(json[:messages].pluck([:id])).to match_array(messages.pluck([:id]))
  end

  it 'returns the body of each one' do
    expect(json[:messages].pluck([:body])).to match_array(messages.pluck([:body]))
  end

  it 'mark messages as read' do
    conversation.reload
    expect(conversation.first_user_unread_messages).to eq(0)
  end

  it 'does not return other\'s users conversations messages' do
    expect(json[:messages].pluck([:id])).not_to include(other_conversation_messages.pluck([:id]))
  end

  context 'when there are many pages' do
    let(:paginates_per) { 10 }
    let(:total_messages) { paginates_per + 2 }
    let!(:messages) do
      create_list(:message, total_messages, user: user, conversation: conversation)
    end
    let(:page) { '1' }

    let(:params) { { page: page } }

    subject { get api_v1_conversation_messages_path(conversation.id), headers: auth_headers, params: params, as: :json }

    before do
      subject
    end

    it 'first page is full' do
      expect(json[:messages].count).to eq(paginates_per)
    end

    it 'first page is full' do
      expect(json[:messages].count).to eq(paginates_per)
    end

    it 'shows the next page link' do
      expect(json[:next_page]).to eq(2)
    end

    context 'when gets next page' do
      let(:page) { '2' }

      it 'has second page not full' do
        expect(json[:messages].count).to eq(total_messages - paginates_per)
      end

      it 'does not have a link to the next page' do
        expect(json[:next_page]).to be_nil
      end
    end
  end
end
