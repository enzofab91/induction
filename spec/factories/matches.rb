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
FactoryBot.define do
  factory :match do
    target

    association :first_user, factory: :user
    association :second_user, factory: :user
  end
end
