class Waypoint < ApplicationRecord
  # model association
  belongs_to :vehicle

  # validations
  validates :vehicle_id, :latitude, :longitude, :sent_at, presence: true
end
