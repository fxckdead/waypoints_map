class Vehicle < ApplicationRecord
  # model association
  has_many :waypoints

  # validations
  validates :identifier, presence: true
end
