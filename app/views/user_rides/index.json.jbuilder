json.ignore_nil!
json.array! @rides do |ride|
  from = ride.route.location_a
  to = ride.route.location_b
  desired_drop = nil
  if !@destination.nil?
    desired_drop = ride.drop_points.joins(:location).merge(
      Location.within(@destination_radius, origin: [@destination[:latitude], @destination[:longitude]])
    ).first
  elsif current_user.reserved_ride?(ride)
    desired_drop = ride.passengers.where(user: current_user).drop_point.take.location
  end

  json.id ride.id
  json.available_seats ride.available_seats
  json.scheduled_datetime ride.scheduled_datetime.strftime("%A, %B %-d %Y at %H:%M")
  json.route do
    json.from do
      json.extract! from, :latitude, :longitude
    end
    json.to do
      json.extract! to, :latitude, :longitude
    end
    if !desired_drop.nil?
      json.desired_drop_point do
        json.id desired_drop.id
        json.extract! desired_drop.location, :latitude, :longitude
      end
    end
  end
  if @app_type == 'Drivers'
    json.driver do
      json.full_name ride.user_owner.full_name
      json.rating ride.user_owner.total_rating
    end
  end
end