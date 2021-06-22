# == Schema Information
#
# Table name: abouts
#
#  id         :bigint           not null, primary key
#  body       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
describe About, type: :model do
  let(:about) { build :about }

  it 'body is present' do
    expect(about.body).to be_present
  end
end
