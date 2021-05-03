describe 'POST api/v1/targets', type: :request do
  subject { post api_v1_targets_path, params: params, headers: auth_headers, as: :json }

  describe 'POST create' do
    let(:user)          { create :user }
    let(:topic)         { create :topic }

    let(:title)           { 'New target' }
    let(:radius)          { 300 }
    let(:coordinates)     { { latitude: -34.6037389, longitude: -58.3837591 } }

    let(:target_created)  { Target.last }

    let(:params) do
      {
        target: {
          title: title,
          radius: radius,
          latitude: coordinates[:latitude],
          longitude: coordinates[:longitude],
          topic_id: topic.id
        }
      }
    end

    it 'returns a successful response' do
      subject

      expect(response).to be_successful
    end

    it 'creates the target' do
      expect {
        subject
      }.to change(Target, :count).by(1)
    end

    it 'assigns the correct user' do
      subject
      expect(target_created.user_id).to eq user.id
    end

    it 'assigns the correct topic' do
      subject
      expect(target_created.topic_id).to eq topic.id
    end

    context 'when matches with another target' do
      let(:second_user)   { create(:user, push_token: [Faker::Number.number(20)]) }
      let!(:second_target) do
        create(
          :target,
          title: 'Pizzeria Guerrin',
          latitude: -34.6037345,
          longitude: -58.3859478,
          radius: 500,
          topic: topic,
          user: second_user
        )
      end
      let(:match_created) { Match.last }

      let(:match_target) { Match.where(first_user_id: user.id).first }

      it 'creates the match' do
        expect {
          subject
        }.to change(Match, :count).by(1)
      end

      it 'returns the match id' do
        subject

        expect(match_target.id).to eq(match_created.id)
      end

      it 'returns the match current user' do
        subject

        expect(match_target.first_user_id).to eq(match_created.first_user_id)
      end

      it 'returns the match second user' do
        subject

        expect(match_target.second_user_id).to eq(match_created.second_user_id)
      end

      it 'sends push notification' do
        allow(FcmService).to receive(:sent_notification)

        subject

        expected_message = {
          name: match_created.second_user.first_name,
          match_id: match_created.id
        }

        expect(FcmService).to have_received(:sent_notification).with(
          [match_created.second_user.push_token],
          I18n.t('api.notifications.new_match'),
          expected_message
        )
      end
    end

    context 'when can not match with any target' do
      it 'does not create the match' do
        expect {
          subject
        }.not_to change(Match, :count)
      end
    end
  end
end
