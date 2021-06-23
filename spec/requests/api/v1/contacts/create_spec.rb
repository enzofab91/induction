describe 'POST api/v1/contacts', type: :request do
  subject { post api_v1_contacts_path, params: params, as: :json }

  describe 'POST create' do
    let(:email) { Faker::Internet.email }
    let(:body) { Faker::Lorem.sentence }

    let(:params) do
      {
        email: email,
        body: body
      }
    end

    it 'returns success' do
      subject
      expect(response).to be_successful
    end

    it 'creates the contact question' do
      expect {
        subject
      }.to change(Contact, :count).by(1)
    end

    context 'with invalid params' do
      let!(:body) { nil }

      it 'returns bad request' do
        subject
        expect(response).to be_bad_request
      end
    end
  end
end
