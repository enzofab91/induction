describe 'GET api/v1/users/:id', type: :request do
  let(:user) { create(:user) }

  subject { get api_v1_user_path(id: user.id), headers: auth_headers, as: :json }

  it 'returns a successfull response' do
    subject
    expect(response).to be_successful
  end

  it 'returns the user' do
    subject

    expect(json[:user][:id]).to eq user.id
    expect(json[:user][:first_name]).to eq user.first_name
    expect(json[:user][:last_name]).to eq user.last_name
    expect(json[:user][:gender]).to eq user.gender
  end
end
