require 'rails_helper'

describe 'DELETE api/v1/users/sign_out', type: :request do
  let(:user) { create(:user) }

  subject { delete destroy_user_session_path, headers: auth_headers, as: :json }

  it 'returns a successful response' do
    subject
    expect(response).to be_successful
  end

  context 'when user is not logged in' do
    let(:auth_headers) { nil }

    it 'does not return a successful response' do
      subject
      expect(response).to have_http_status(404)
    end
  end
end
