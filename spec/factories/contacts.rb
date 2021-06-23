FactoryBot.define do
  factory :contact do
    email { Faker::Internet.email }
    body { Faker::Lorem.sentence }
  end
end
