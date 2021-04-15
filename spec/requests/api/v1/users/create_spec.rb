require 'rails_helper'

describe 'User Api', type: :request do
  let(:failed_response) { 422 }

  describe 'POST api/v1/users/' do
    let(:email)                 { 'test@test.com' }
    let(:password)              { '12345678' }
    let(:password_confirmation) { '12345678' }
    let(:gender)                { 'M' }

    let(:params) do
      {
        user: {
          email: email,
          password: password,
          password_confirmation: password_confirmation,
          gender: gender
        }
      }
    end

    it 'returns a successful response' do
      post user_registration_path, params: params, as: :json

      expect(response).to have_http_status(:success)
    end

    it 'creates the user' do
      expect {
        post user_registration_path, params: params, as: :json
      }.to change(User, :count).by(1)
    end

    it 'returns the user' do
      post user_registration_path, params: params, as: :json

      expect(response.body).to include_json(
        {
          status: 'success',
          data: {
            email: email,
            gender: gender,
            provider: 'email',
            uid: email
          }
        }
      )
    end

    context 'when passwords dont match' do
      let(:password_confirmation) { '12345' }

      it 'does not return a successful response' do
        post user_registration_path, params: params, as: :json

        expect(response.status).to eq(failed_response)
      end

      it 'does not create new user' do
        post user_registration_path, params: params, as: :json

        expect {
          post user_registration_path, params: params, as: :json
        }.not_to change(User, :count)
      end

      it 'returns message error' do
        post user_registration_path, params: params, as: :json

        expect(response.body).to include_json(
          {
            status: 'error',
            errors: {
              password_confirmation: ['doesn\'t match Password']
            }
          }
        )
      end
    end
  end
end
