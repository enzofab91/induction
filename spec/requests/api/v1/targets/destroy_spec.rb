describe 'DELETE api/v1/targets', type: :request do
  subject { delete api_v1_target_path(target_id), headers: auth_headers, as: :json }

  let(:user)                  { create :user }
  let!(:target)               { create :target, user: user }
  let(:other_users_target)    { create :target }
  let(:target_id)             { target.id }

  context 'for an existing target' do
    context 'when target belongs to current user' do
      it 'returns a successful response' do
        subject
        expect(response).to be_successful
      end

      it 'delete the target' do
        expect {
          subject
        }.to change(user.targets, :count).by(-1)
      end
    end

    context 'when target do not belongs to current user' do
      let(:target_id) { other_users_target.id }

      it 'does not return a successful response' do
        subject
        expect(response).to be_not_found
      end

      it 'does not delete the target' do
        expect {
          subject
        }.not_to change(user.targets, :count)
      end
    end

    context 'for an unexisting target' do
      let(:target_id) { 'none' }

      it 'does not return a successful response' do
        subject
        expect(response).to be_not_found
      end
    end
  end
end
