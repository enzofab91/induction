describe 'GET api/v1/users/confirmation', type: :request do
  subject { get user_confirmation_path, params: params, as: :json }

  let(:user) { create(:user, confirmed_at: nil) }
  let(:confirmation_token) { user.confirmation_token }

  let(:params) do
    {
      confirmation_token: confirmation_token
    }
  end

  it 'returns a successful response' do
    subject

    expect(response).to be_successful
  end

  it 'confirms the user email' do
    subject

    expect(user.reload.confirmed?).to be true
  end

  context 'when token is not valid' do
    let(:confirmation_token) { 'invalid_token' }

    it 'does not return a successful response' do
      subject

      expect(response).to be_unprocessable
    end

    it 'does not confirms the user email' do
      subject

      expect(user.reload.confirmed?).to be false
    end
  end
end
