# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE), not null
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           default("")
#  gender                 :string(1)        default("")
#  last_name              :string           default("")
#  provider               :string           default("email"), not null
#  push_token             :string
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
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  include DeviseTokenAuth::Concerns::User

  validates :email, presence: true, uniqueness: true

  has_many :targets, dependent: :destroy
  has_many :user_conversations, dependent: :destroy
  has_many :conversations, through: :user_conversations, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_one_attached :photo

  def photo_url
    return unless photo.attached?

    Rails
      .application
      .routes
      .url_helpers
      .rails_blob_url(photo, disposition: 'attachment')
  end

  # :reek:FeatureEnvy
  def update!(user_params)
    photo.attach(
      io: File.open(user_params[:photo_io]),
      filename: user_params[:photo_filename]
    )
  end

  def self.from_social_provider(provider, user_params)
    where(provider: provider, uid: user_params['id']).first_or_create do |user|
      user.password = Devise.friendly_token[0, 20]
      user.confirm
      user.assign_attributes(user_params.except('id'))
    end
  end
end
