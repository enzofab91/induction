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
class Match < ApplicationRecord
  belongs_to :first_user, class_name: 'User'
  belongs_to :second_user, class_name: 'User'
  belongs_to :target

  validate :users_are_different

  private

  def users_are_different
    return unless first_user.id == second_user.id

    errors.add(:match, I18n.t('api.errors.match_same_user'))
  end
end
