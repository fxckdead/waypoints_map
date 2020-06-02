# spec/factories/waypoints.rb

FactoryBot.define do
  factory :waypoint do
    vehicle { create(:vehicle) }
    latitude { rand(37..38) }
    longitude { rand(-122..-121) }
    sent_at { Time.zone.now }
    created_at { Time.zone.now }
  end
end
# Validation failed: Vehicle must exist, Vehicle can't be blank
# Validation failed: Vehicle can't be blank