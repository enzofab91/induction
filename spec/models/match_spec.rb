# == Schema Information
#
# Table name: matches
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  first_user_id  :bigint           not null
#  second_user_id :bigint           not null
#  target_id      :bigint           not null
#
# Indexes
#
#  index_matches_on_first_user_id   (first_user_id)
#  index_matches_on_second_user_id  (second_user_id)
#  index_matches_on_target_id       (target_id)
#
describe Match, type: :model do
  subject(:match) { build :match }

  describe 'validations' do
    context 'when first and second user are the same' do
      let(:user)  { create(:user) }
      let(:match) { build(:match, first_user_id: user.id, second_user_id: user.id) }

      it 'is not valid' do
        expect(match).to_not be_valid
      end

      it 'returns error message' do
        match.valid?
        expect(match.errors[:match]).to include I18n.t('api.errors.match_same_user')
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:first_user) }
    it { should belong_to(:second_user) }
    it { should belong_to(:target) }
  end
end
