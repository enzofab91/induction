describe ConversationChannel, type: :channel do
  let(:first_user)    { create(:user) }
  let(:second_user)   { create(:user, push_token: [Faker::Number.number(20)]) }
  let(:match)         { create(:match, first_user: first_user, second_user: second_user) }
  let!(:conversation) { create(:conversation, users: [first_user, second_user], match: match) }
  let(:message)       { 'Hello World' }
  let(:action_cable)  { ActionCable.server }
  let(:notifications_path) { 'https://fcm.googleapis.com/fcm/send' }

  let(:params) do
    {
      conversation_id: conversation.id,
      user_id: first_user.id,
      body: message
    }
  end

  before do
    # initialize connection with identifiers
    stub_connection current_user: :first_user

    stub_request(:post, notifications_path)
      .to_return(status: 200, body: '')

    subscribe(params)
  end

  it 'successfully subscribes' do
    expect(subscription).to be_confirmed
  end

  context 'when user sends a message' do
    subject { perform :send_message, user_id: params[:user_id], body: params[:body], conversation_id: params[:conversation_id] }

    it 'saves the new message' do
      expect {
        subject
      }.to change(Message, :count).by(1)
    end

    it 'broadcasts to the conversation channel' do
      expect {
        subject
      }.to have_broadcasted_to(conversation).with(body: message).from_channel(ConversationChannel)
    end

    it 'sends a push notification to the other user' do
      allow(FcmService).to receive(:sent_notification)

      subject

      expect(FcmService).to have_received(:sent_notification).with(
        [second_user.push_token],
        I18n.t('api.notifications.new_message'),
        message
      )
    end
  end
end
