require 'rails_helper'

describe 'POST api/v1/users/sign_in', type: :request do
  subject { post user_session_path, params: params, as: :json }

  let(:failed_response) { 401 }

  describe 'POST create' do
    let(:password)              { '12345678' }
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

    let(:user) { create(:user, gender: gender, password: password, tokens: token) }

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

      expect(response.body).to include_json(
        {
          data: {
            email: user.email,
            gender: user.gender,
            provider: 'email',
            uid: user.email
          }
        }
      )
    end

    it 'returns a valid acces token' do
      subject

      token = response.header['access-token']
      expect(token).to be_truthy
    end

    context 'when credentials dont match' do
      it 'does not return a successful response' do
        params = {
          user: {
            email: user.email,
            password: 'wrong_password'
          }
        }

        post user_session_path, params: params, as: :json

        expect(response.status).to eq(failed_response)
      end

      it 'returns message error' do
        params = {
          user: {
            email: user.email,
            password: 'wrong_password'
          }
        }

        post user_session_path, params: params, as: :json

        expect(response.body).to include_json(
          {
            error: 'Invalid login credentials. Please try again.'
          }
        )
      end
    end
  end
end
