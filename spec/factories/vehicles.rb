# spec/factories/vehicles.rb

FactoryBot.define do
  factory :vehicle do
    sequence(:identifier) { |n| "#{Faker::Movies::StarWars.droid}-#{n}" }
  end
end
