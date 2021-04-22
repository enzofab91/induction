require 'rails_helper'

describe 'DELETE api/v1/users/sign_out', type: :request do
  let(:user) { create(:user) }

  subject { delete destroy_user_session_path, headers: auth_headers, as: :json }

  it 'returns a successful response' do
    subject
    expect(response).to be_successful
  end

  context 'when user is not logged in' do
    let(:headers) { nil }

    it 'does not return a successful response' do
      expect(response).to_not have_http_status(:success)
    end
  end
end
