module Api
  module V1
    class GpsController < Api::BaseController
      wrap_parameters false

      def create
        # - Can receive an array or single object, so must handle both cases (i guess)
        # - Parameters are sent as plain objects as recomendation of sidekiq
        #   https://github.com/mperham/sidekiq/wiki/Best-Practices#1-make-your-job-parameters-small-and-simple

        if waypoint_params.empty?
          return render json: { error: "no data" }, status: :unprocessable_entity
        end

        if waypoint_params.include?(:_json)
          waypoint_params[:_json].each { |waypoint| create_async_job(waypoint) }
        else
          create_async_job(waypoint_params)
        end

        # - Cant give feedback since waypoints are proccesed as async jobs
        # - If its an M2M device should not expect response coz low bandwith/memory on device

        render json: { success: true }, status: :created
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
          waypoint[:vehicle_identifier], waypoint[:sent_at],
          waypoint[:latitude], waypoint[:longitude]
        )
      end
    end
  end
end
