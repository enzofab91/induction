# == Schema Information
#
# Table name: contacts
#
#  id         :bigint           not null, primary key
#  body       :string           not null
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :contact do
    email { Faker::Internet.email }
    body { Faker::Lorem.sentence }
  end
end
