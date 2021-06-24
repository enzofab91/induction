# == Schema Information
#
# Table name: abouts
#
#  id         :bigint           not null, primary key
#  body       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class About < ApplicationRecord
  validates :body, presence: true
end
