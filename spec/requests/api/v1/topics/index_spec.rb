require 'rails_helper'

describe 'GET api/v1/topics', type: :request do
  let(:user)    { create :user }
  let!(:topics) { create_list :topic, 5 }

  subject { get api_v1_topics_path, headers: auth_headers, as: :json }

  it 'returns success' do
    subject

    expect(response).to have_http_status(:success)
  end

  it 'returns all topics' do
    subject

    expect(json[:topics].pluck([:name])).to match_array(topics.pluck([:name]))
  end
end
