describe 'PATCH api/v1/users/:id', type: :request do
  subject { patch api_v1_user_path(id: user.id), params: params, headers: auth_headers, as: :json }

  let(:file) do
    File.open(File.join(Rails.root, 'spec/fixtures/files/', 'profile_logo.png')).read
  end

  let(:base64_data) { "data:image/png;base64,#{Base64.encode64(file)}" }

  let(:user) { create(:user) }

  let(:params) do
    {
      user: {
        first_name: user.first_name,
        last_name: user.last_name,
        photo_io: File.join(Rails.root, 'spec/fixtures/files/', 'profile_logo.png'),
        photo_filename: 'profile_logo.png'
      }
    }
  end

  it 'returns a successfull response' do
    subject
    expect(response).to be_successful
  end

  it 'updates the user first name' do
    subject

    expect(user.reload.first_name).to eq(params[:user][:first_name])
  end

  it 'updates the user last name' do
    subject

    expect(user.reload.last_name).to eq(params[:user][:last_name])
  end

  it 'returns the user id' do
    subject
    expect(json[:user][:id]).to eq user.id
  end

  it 'returns the first name' do
    subject
    expect(json[:user][:first_name]).to eq user.first_name
  end

  it 'returns the last name' do
    subject
    expect(json[:user][:last_name]).to eq user.last_name
  end

  it 'returns the gender' do
    subject
    expect(json[:user][:gender]).to eq user.gender
  end

  it 'updates the user profile photo' do
    subject
    expect(json[:user][:photo_url]).to be_present
  end
end
