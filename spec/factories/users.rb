# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           default("")
#  gender                 :string(1)        default("")
#  last_name              :string           default("")
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  targets_count          :integer
#  tokens                 :json
#  uid                    :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
FactoryBot.define do
  factory :user do
    email               { Faker::Internet.unique.email }
    password            { Faker::Internet.password(min_length: 8) }
    confirmation_token  { Faker::Number.unique.number(digits: 10) }
    confirmed_at        { Faker::Time.between_dates(from: 2.days.ago, to: Time.zone.now, period: :all) }
    first_name          { Faker::Name.name }
    last_name           { Faker::Name.name }
  end
end
