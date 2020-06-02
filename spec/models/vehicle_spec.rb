# spec/models/vehicle_spec.rb
require 'rails_helper'

# Test suite for the Vehicle model
RSpec.describe Vehicle, type: :model do
  # Association test
  it { should have_many(:waypoints) }

  # Validation tests
  it { should validate_presence_of(:identifier) }
end