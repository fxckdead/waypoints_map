class Vehicle < ApplicationRecord
  # model association
  has_many :waypoints

  # validations
  validates_presence_of :identifier
end
