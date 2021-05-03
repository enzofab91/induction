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

  def self.create_and_notify(targets, user_id)
    targets.find_each do |target|
      created_match = create!(first_user_id: user_id, second_user_id: target.user_id,
                              target_id: target.id)
      notify_match(created_match)
    end
  end

  def self.notify_match(match)
    second_user = match.second_user

    data = Hash(name: second_user.first_name, match_id: match.id)

    registration_ids = [second_user.push_token]

    FcmService.sent_notification(registration_ids, I18n.t('api.notifications.new_match'), data)
  end

  private

  def users_are_different
    return unless first_user.id == second_user.id

    errors.add(:match, I18n.t('api.errors.match_same_user'))
  end
end
