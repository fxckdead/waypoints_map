# spec/factories/vehicles.rb

FactoryBot.define do
  factory :vehicle do
    sequence(:identifier) { |n| "#{Faker::Movies::StarWars.droid}-#{n}" }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end
end