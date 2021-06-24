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
describe Contact, type: :model do
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:email) }
end
