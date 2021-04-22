describe 'POST api/v1/targets', type: :request do
  subject { post api_v1_targets_path, params: params, headers: auth_headers, as: :json }

  describe 'POST create' do
    let(:user)          { create :user }
    let(:topic)         { create :topic }

    let(:title)           { 'New target' }
    let(:radius)          { 300 }
    let(:coordinates)     { Hash(latitude: -34.6037389, longitude: -58.3837591) }
    let(:longitude)       { 60.12 }

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
  end
end
