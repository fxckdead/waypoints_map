class StoreWaypoint
  include Sidekiq::Worker

  def perform(vehicle_identifier, sent_at, latitude, longitude)
    vehicle = Vehicle.create_or_find_by(identifier: vehicle_identifier)

    vehicle.waypoints.create(
      latitude: latitude,
      longitude: longitude,
      sent_at: sent_at,
    )
  end
end
