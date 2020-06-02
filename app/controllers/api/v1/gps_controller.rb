class Api::V1::GpsController < Api::BaseController
  wrap_parameters false

  def create
    # - Can receive an array or single object, so must handle both cases (i guess)
    # - Parameters are sent as plain objects as recomendation of sidekiq 
    #   https://github.com/mperham/sidekiq/wiki/Best-Practices#1-make-your-job-parameters-small-and-simple

    return render json: { error: "no data" }, status: 422 if waypoint_params.empty?

    if waypoint_params.include?(:_json)
      waypoint_params[:_json].each do |wp|
        create_async_job(wp)
      end
    else
      create_async_job(waypoint_params)
    end

    # - Cant give feedback since waypoints are proccesed as async jobs
    # - If its an M2M device should not expect response coz low bandwith/memory on device

    render json: { success: true }, status: 201
  end

  private

  def waypoint_params
    # - This way i can accept an array or single objects.
    # - `_json` is a key that rails parms parser add when passing an array

    params.permit(
      :latitude, :longitude, :sent_at, :vehicle_identifier,
      { _json: [:latitude, :longitude, :sent_at, :vehicle_identifier] }
    )
  end

  def create_async_job(waypoint)
    StoreWaypoint.perform_async(
      waypoint[:latitude], waypoint[:longitude],
      waypoint[:sent_at], waypoint[:vehicle_identifier]
    )
  end
end
