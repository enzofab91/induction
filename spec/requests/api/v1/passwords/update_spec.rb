describe 'PUT api/v1/passwords/', type: :request do
  let!(:user) { create(:user) }
  let(:password) { 'new_password' }
  let(:password_confirmation) { 'new_password' }

  let(:params) { { password: password, password_confirmation: password_confirmation } }

  subject { put user_password_path, params: params, headers: auth_headers, as: :json }

  context 'with valid params' do
    it 'returns a successful response' do
      subject

      expect(response).to be_successful
    end
  end

  context 'with invalid params' do
    let(:password_confirmation) { 'unmatching_password' }

    it 'does not return a successful response nor change the password' do
      subject

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
