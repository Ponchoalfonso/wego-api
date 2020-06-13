class UserRidesController < ApplicationController
  before_action :driver_only, only: [:create]
  skip_before_action :admin_only

  def index
    @app_type = application_type
    
    if application_type == 'Drivers'
      @rides = current_user.owned_rides
    elsif application_type == 'Customers'
      @rides = current_user.rides
    end

    if @rides&.length < 1
      head 404
    end
  end

  def search
    # Get search elements
    @origin_radius = search_params[:origin_radius].nil? ? 0.3 : search_params[:origin_radius]
    @destination_radius = search_params[:destination_radius].nil? ? 0.5 : search_params[:destination_radius]
    origin = search_params['origin']
    @destination = search_params['destination']
    departure = DateTime.parse(search_params['departure_datetime'])

    # Choose candidate routes by the given origin
    rides_by_origin = Ride.joins(:route).merge(
      Route.joins(:location_a).merge(
        Location.within(@origin_radius, origin: [origin[:latitude], origin[:longitude]])
      )
    ).where(finished: false) # Search rides that are available
    .where( # Search a ride in a period of 20 minutes around the given time
      "scheduled_datetime >= ? AND scheduled_datetime <= ?",
      departure - 10.minutes,
      departure + 10.minutes
    )

    # Choose candidate routes by the given destination
    rides_by_destination = Ride.joins(:drop_points).merge(
      DropPoint.joins(:location).merge(
        Location.within(@destination_radius, origin: [@destination[:latitude], @destination[:longitude]])
      )
    ).where(finished: false).distinct # Remove duplicateds
    
    @rides = []

    # Manual merge of the two queries
    rides_by_origin.each_with_index do |origin|
      rides_by_destination.each do |dest|
        # Make sure the ride has available seats
        if origin.id == dest.id and origin.available_seats > 0
          @rides << origin
        end
      end
    end

    render :index, status: :ok
  end

  def show
    @app_type = application_type
    if @app_type == 'Drivers' or @app_type == 'Admins'
      @ride = Ride.where(user_owner: current_user).find(params[:id])
    elsif @app_type == 'Customers'
      @ride = Ride.find(params[:id])
    else
      head 403
    end
  end

  def create
    # Make sure only drivers cand create routes
    if current_user&.role.name != 'driver' and current_user&.role.name != 'admin'
      return head 403
    end

    route = Route.new

    # Fetching route or creating a new one if it doesn't exist
    if ride_params[:route][:id].nil?
      a = Location.new(
        latitude: ride_params[:route][:location_a][:latitude],
        longitude: ride_params[:route][:location_a][:longitude]
      )

      b = Location.new(
        latitude: ride_params[:route][:location_b][:latitude],
        longitude: ride_params[:route][:location_b][:longitude]
      )

      route = Route.new(
        location_a: a,
        location_b: b
      )
    else
      route = Route.find(ride_params[:route][:id])
    end

    # Creating or adding drop points that don't carry an ID
    received_drop_points = []
    if !ride_params[:route][:drop_points].nil?
      ride_params[:route][:drop_points].each do |drop_point|
        if drop_point[:id].nil?
          dp =  DropPoint.new(
            location: Location.new(
              latitude: drop_point[:latitude],
              longitude: drop_point[:longitude]
            )
          )
          route.drop_points << dp
          received_drop_points << dp
        else
          received_drop_points << DropPoint.find(drop_point[:id])
        end
      end
    end
    
    # Creating ride
    @ride = Ride.new(
      user_owner: current_user,
      route: route,
      seats: ride_params[:seats],
      scheduled_datetime: ride_params[:scheduled_datetime]
    )

    # Attempt to save the ride
    if @ride.save
      # Check if the user removed drop points
      if @ride.drop_points.length != received_drop_points.length
        @ride.drop_points.each do |old_dp|
          # Don't delete drop point if it is being used by other ride
          related_rides = old_dp.route.rides.where(finished: false)
          if !received_drop_points.include?(old_dp) and related_rides.length <= 1
            old_dp.delete
          end
        end
      end

      render :show, status: :created
    else
      render json: @ride.errors, status: :unprocessable_entity
    end
  end

  private
    def search_params
      params.require(:search).permit(
        :origin_radius,
        :destination_radius,
        :departure_datetime,
        origin: [:latitude, :longitude],
        destination: [:latitude, :longitude]
      )
    end

    def ride_params
      params.require(:ride).permit(:scheduled_datetime, :seats, route: {})
    end
end
