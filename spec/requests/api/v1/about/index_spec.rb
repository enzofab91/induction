describe 'GET api/v1/about/', type: :request do
  let!(:about) { create(:about) }

  subject { get api_v1_about_index_path, as: :json }

  it 'returns a successfull response' do
    subject
    expect(response).to be_successful
  end

  it 'returns the about info' do
    subject
    expect(json[:about][:body]).to eq(about[:body])
  end
end
