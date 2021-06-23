class Contact < ApplicationRecord
  validates :body, :email, presence: true
end
