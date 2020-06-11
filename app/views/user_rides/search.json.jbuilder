json.ignore_nil!
json.array! @rides do |ride|
  from = ride.route.location_a
  desired_drop = ride.drop_points.joins(:location).merge(
    Location.within(0.3, origin: @destination)
  ).take.location

  json.id ride.id
  json.available_seats ride.available_seats
  json.scheduled_datetime ride.scheduled_datetime.strftime("%A, %B %-d %Y at %H:%M")
  json.route do
    json.from [from.latitude, from.longitude]
    json.desired_drop_point [desired_drop.latitude, desired_drop.longitude]
  end
  json.driver do
    json.full_name ride.user_owner.full_name
  end
end