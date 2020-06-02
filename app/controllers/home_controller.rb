class HomeController < ApplicationController
  def show_map
    # This will get the lastest Waypoint for the vehicles
    sql = <<~SQL
      SELECT DISTINCT ON (vehicle_id) vehicles.id as vehicleId, vehicles.identifier, latitude, longitude, sent_at
      FROM waypoints
      RIGHT JOIN vehicles ON vehicles.id = waypoints.vehicle_id
      ORDER BY vehicle_id ASC, sent_at DESC;
    SQL

    @vehicles = ActiveRecord::Base.connection.execute(sql)
  end
end
