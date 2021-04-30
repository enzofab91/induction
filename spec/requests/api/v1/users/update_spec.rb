describe 'PATCH api/v1/users/:id', type: :request do
  subject { patch api_v1_user_path(id: user.id), params: params, headers: auth_headers, as: :json }

  let(:user) { create(:user) }

  let(:params) do
    {
      user: {
        first_name: user.first_name,
        last_name: user.last_name
      }
    }
  end

  it 'returns a successfull response' do
    subject
    expect(response).to be_successful
  end

  it 'updates the user' do
    subject

    expect(user.reload.first_name).to eq(params[:user][:first_name])
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
end
