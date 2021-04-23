describe 'GET api/v1/targets', type: :request do
  let(:user)                  { create :user }
  let!(:targets)              { create_list :target, 5, user: user }
  let!(:other_user_targets)   { create_list :target, 5 }

  subject { get api_v1_targets_path, headers: auth_headers, as: :json }

  it 'returns a successful response' do
    subject
    expect(response).to be_successful
  end

  it 'returns user targets' do
    subject
    expect(json[:targets].pluck([:id])).to match_array(targets.pluck([:id]))
  end

  it 'does not returns other\'s users targets' do
    subject
    expect(json[:targets].pluck([:id])).not_to include(other_user_targets.pluck([:id]))
  end
end
