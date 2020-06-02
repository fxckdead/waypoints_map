class Waypoint < ApplicationRecord
  # model association
  belongs_to :vehicle

  # validations
  validates_presence_of :vehicle_id, :latitude, :longitude, :sent_at
end
