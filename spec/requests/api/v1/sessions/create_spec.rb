describe 'POST api/v1/users/sign_in', type: :request do
  subject { post user_session_path, params: params, as: :json }

  let(:failed_response) { 401 }

  describe 'POST create' do
    let(:password)              { '12345678' }
    let(:user_password)         { '12345678' }
    let(:gender)                { 'M' }

    let(:token) do
      {
        '70crCAAYmNP1xLkKKM09zA' =>
        {
          'token' => 'k_csguHtnEMcXL6s-UmBBQ',
          'expiry' => 153_574_356_4
        }
      }
    end

    let(:user) { create(:user, gender: gender, password: user_password, tokens: token, confirmed_at: Time.zone.now) }

    let(:params) do
      {
        user: {
          email: user.email,
          password: password
        }
      }
    end

    it 'returns a successful response' do
      subject

      expect(response).to be_successful
    end

    it 'returns the user' do
      subject

      expect(json[:user][:email]).to eq(user.email)
      expect(json[:user][:gender]).to eq(user.gender)
      expect(json[:user][:provider]).to eq('email')
      expect(json[:user][:uid]).to eq(user.email)
    end

    it 'returns a valid acces token' do
      subject

      token = response.header['access-token']
      expect(token).to be_truthy
    end

    context 'when credentials dont match' do
      let(:password) { 'wrong_password!' }

      it 'does not return a successful response' do
        subject

        expect(response.status).to eq(failed_response)
      end

      it 'returns message error' do
        subject

        expect(response.body).to include_json(
          {
            error: I18n.t('spec.errors.invalid_login_credentials')
          }
        )
      end
    end
  end
end
