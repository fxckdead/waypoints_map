# spec/models/waypoint_spec.rb
require 'rails_helper'

# Test suite for the Item model
RSpec.describe Waypoint, type: :model do
  # Association test
  it { should belong_to(:vehicle) }

  # Validation test
  it { should validate_presence_of(:vehicle_id) }
  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }
  it { should validate_presence_of(:sent_at) }
end