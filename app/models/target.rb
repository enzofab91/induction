# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  latitude   :float            not null
#  longitude  :float            not null
#  radius     :float            not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_targets_on_topic_id  (topic_id)
#  index_targets_on_user_id   (user_id)
#
class Target < ApplicationRecord
  USER_MAX_TARGET_LIMIT = 10

  belongs_to :user
  belongs_to :topic

  validates :title, :latitude, :longitude, :radius, presence: true
  validates :radius, numericality: { greater_than: 0 }

  validate :target_limit, on: :create

  acts_as_mappable :default_units => :meters,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  after_create :create_matches

  has_many :matches, dependent: :destroy

  def expired?
    created_at + 7 < Time.zone.now
  end

  private

  def target_limit
    return unless user.targets.count == USER_MAX_TARGET_LIMIT

    errors.add(:targets, I18n.t('api.errors.target_limit'))
  end

  def create_matches
    target_query = TargetsNearUserQuery.new
    targets = target_query.call(self)

    targets.find_each do |target|
      new_match = Hash(first_user_id: user_id, second_user_id: target.user_id, target_id: target.id)
      match_form = MatchForm.new(match_attributes: new_match)
      match_form.save
    end
  end
end
