class StoreWaypoint
  include Sidekiq::Worker

  def perform(latitude, longitude, sent_at, vehicle_identifier)
    vehicle = Vehicle.create_or_find_by(identifier: vehicle_identifier)

    vehicle.waypoints.create(
      latitude: latitude,
      longitude: longitude,
      sent_at: sent_at,
    )
  end
end
