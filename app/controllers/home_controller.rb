class HomeController < ApplicationController
  # This will get the lastest Waypoint for the vehicles
  SQL_QUERY = <<~SQL.freeze
    SELECT DISTINCT ON (vehicle_id) vehicle_id, vehicles.identifier, latitude, longitude, sent_at
    FROM waypoints
    RIGHT JOIN vehicles ON vehicles.id = waypoints.vehicle_id
    ORDER BY vehicle_id ASC, sent_at DESC;
  SQL

  def show_map
    @vehicles = ActiveRecord::Base.connection.execute(SQL_QUERY)
  end
end
