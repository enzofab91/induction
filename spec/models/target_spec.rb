# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  latitude   :float            not null
#  longitude  :float            not null
#  radius     :float            not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_targets_on_topic_id  (topic_id)
#  index_targets_on_user_id   (user_id)
#
require 'rails_helper'

RSpec.describe Target, type: :model do
  describe 'validations' do
    subject(:target) { build :target }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:radius) }
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longitude) }

    describe 'amount of targets limit reached' do
      let(:user) { create(:user) }
      let!(:targets) { create_list(:target, Target::USER_MAX_TARGET_LIMIT, user_id: user.id) }
      let(:target) { build(:target, user_id: user.id) }

      it 'it does not create a new target' do
        expect(target).to_not be_valid
      end

      it 'returns error message' do
        target.valid?
        expect(target.errors[:targets]).to include I18n.t('api.errors.target_limit')
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:topic) }
  end
end
