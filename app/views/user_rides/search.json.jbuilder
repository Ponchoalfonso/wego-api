json.ignore_nil!
json.array! @rides do |ride|
  from = ride.route.location_a
  desired_drop = ride.drop_points.joins(:location).merge(
    Location.within(@destination_radius, origin: [@destination[:latitude], @destination[:longitude]])
  ).take.location

  json.id ride.id
  json.available_seats ride.available_seats
  json.scheduled_datetime ride.scheduled_datetime.strftime("%A, %B %-d %Y at %H:%M")
  json.route do
    json.from do
      json.latitude from.latitude
      json.longitude from.longitude
    end
    json.desired_drop_point do
      json.latitude desired_drop.latitude
      json.longitude desired_drop.longitude 
    end
  end
  json.driver do
    json.full_name ride.user_owner.full_name
    json.rating ride.user_owner.total_rating
  end
end