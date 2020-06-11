class UserRidesController < ApplicationController
  def search
    origin = params['search']['origin']
    @destination = params['search']['destination']
    departure = params['search']['departure_datetime']

    rides_by_origin = Ride.joins(:route).merge(
      Route.joins(:location_a).merge(
        Location.within(0.3, origin: origin)
      )
    ).where(finished: false)
    .where(
      "scheduled_datetime >= ? AND scheduled_datetime <= ?",
      DateTime.new(departure.to_i - 600),
      DateTime.new(departure.to_i + 600)
    )

    rides_by_destination = Ride.joins(:drop_points).merge(
      DropPoint.joins(:location).merge(
        Location.within(0.3, origin: @destination)
      )
    ).where(finished: false).distinct
    
    @rides = []

    rides_by_origin.each_with_index do |origin|
      rides_by_destination.each do |dest|
        if origin.id == dest.id and origin.available_seats > 0
          @rides << origin
        end
      end
    end

    render :search, status: :ok
  end

  def create

  end

  private
    def search_params
      params.require(:search).permit(:departure_datetime, :origin => [], :destination => [])
    end
end
