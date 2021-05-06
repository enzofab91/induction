describe 'GET api/v1/users/passwords/edit', type: :request do
  let!(:user) { create(:user) }
  let(:password_token) { user.send(:set_reset_password_token) }
  let(:params) { { reset_password_token: password_token, redirect_url: 'http://www.example.com' } }

  subject { get edit_user_password_path, params: params }

  it 'returns access token' do
    subject

    expect(response.header['Location']).to include('token')
  end

  it 'returns uid' do
    subject

    expect(response.header['Location']).to include('uid')
  end

  it 'returns client id' do
    subject

    expect(response.header['Location']).to include('client_id')
  end
end
