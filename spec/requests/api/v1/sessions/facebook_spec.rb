describe 'POST api/v1/users/facebook', type: :request do
  let(:facebook_api_path) { 'https://graph.facebook.com/me' }
  let(:fields)            { 'email,first_name,last_name' }
  let(:first_name)        { 'Jhon' }
  let(:last_name)         { 'Doe' }
  let(:email)             { 'test@facebook.com' }
  let(:uid)               { '123456789' }
  let(:token)             { '123456' }
  let(:facebook_response) do
    {
      first_name: first_name,
      last_name: last_name,
      email: email,
      id: uid
    }
  end

  let(:params) { { access_token: token } }

  subject do
    post facebook_api_v1_users_path, params: params, as: :json
  end

  before do
    stub_request(:get, facebook_api_path)
      .with(query: hash_including(access_token: token, fields: fields))
      .to_return(status: 200, body: facebook_response.to_json)
  end

  it 'returns a successful response' do
    subject
    expect(response).to be_successful
  end

  it 'creates the user' do
    expect { subject }.to change(User, :count).by(1)
  end

  it 'assigns the information properly' do
    subject

    expect(json[:user][:email]).to eq(email)
    expect(json[:user][:first_name]).to eq(first_name)
    expect(json[:user][:last_name]).to eq(last_name)
    expect(json[:user][:uid]).to eq(uid)
    expect(json[:user][:provider]).to eq('facebook')
  end

  it 'returns a valid client and access token' do
    subject

    token = response.header['access-token']
    client = response.header['client']
    user = User.last

    expect(user.reload.valid_token?(token, client)).to be_truthy
  end

  context 'when the user has already logged with facebook' do
    before do
      create(:user, email: email, provider: 'facebook', uid: uid)
    end

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'does not create an user' do
      expect { subject }.to change(User, :count).by(0)
    end
  end

  context 'with invalid params' do
    let(:token)           { 'invalid' }
    let(:failed_response) { 403 }

    facebook_response = {
      error: {
        message: 'Expired token',
        type: 'OAuthException',
        code: 190
      }
    }

    before do
      stub_request(:get, facebook_api_path)
        .with(query: hash_including(access_token: token, fields: fields))
        .to_return(status: 400, body: facebook_response.to_json)
    end

    it 'does not returns a successful response' do
      expect(subject).to eq(failed_response)
    end

    it 'does not create an user' do
      expect { subject }.not_to change(User, :count)
    end
  end
end
