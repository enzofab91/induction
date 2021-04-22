describe 'GET api/v1/topics', type: :request do
  let(:user)    { create :user }
  let!(:topics) { create_list :topic, 5 }

  subject { get api_v1_topics_path, headers: auth_headers, as: :json }

  before do
    subject
  end

  it 'returns a successful response' do
    expect(response).to be_successful
  end

  it 'returns all topics' do
    expect(json[:topics].pluck([:name])).to match_array(topics.pluck([:name]))
  end
end
