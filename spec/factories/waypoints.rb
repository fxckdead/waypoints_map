# spec/factories/waypoints.rb

FactoryBot.define do
  factory :waypoint do
    vehicle { create(:vehicle) }
    latitude { rand(37..38) }
    longitude { rand(-122..-121) }
    sent_at { Time.zone.now }
  end
end
