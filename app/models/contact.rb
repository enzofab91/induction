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
class Contact < ApplicationRecord
  validates :body, :email, presence: true
end
