class UserRidesController < ApplicationController
  def search
    origin = params['search']['origin']
    destination = params['search']['destination']
    departure = params['search']['departure_datetime']

    candidate_routes = Route.joins(:rides).where(rides: {finished: false})
    candidate_origins = candidate_routes.joins(:location_a).merge(Location.within(0.3, origin: origin))
    candidate_drop_points = DropPoint.joins(:location).merge(Location.within(0.3, origin: destination))
    candidate_destinations = candidate_routes.joins(:drop_points).merge(candidate_drop_points)
    routes_id = []
    drops_id = []

    candidate_origins.each do |origin|
      candidate_destinations.each do |destination|
        if origin.id == destination.id
          routes_id << origin.id
          drops_id << candidate_drop_points.where(route: destination).take.id
          break
        end
      end
    end

    candidate_rides = Ride.where(finished: false, route_id: routes_id)
    .where("scheduled_datetime >= ? AND scheduled_datetime <= ?", DateTime.new(departure.to_i - 600), DateTime.new(departure.to_i + 600))
    # .order("ABS(scheduled_datetime - \"#{departure}\")")

    candidate_drop_points = DropPoint.where(id: drops_id)

    @candidates = []

    candidate_rides.each_with_index do |ride, index|
      @candidates << {
        ride: ride,
        drop_point: candidate_drop_points[index],
        driver: ride.user_owner,
        vehicle: ride.user_owner.vehicle,
      }
    end

    if @candidates.length > 0
      render json: @candidates
    else
      head 404
    end
  end

  private
    def search_params
      params.require(:search).permit(:departure_datetime, :origin => [], :destination => [])
    end
end
