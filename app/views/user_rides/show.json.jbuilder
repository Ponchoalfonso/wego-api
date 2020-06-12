json.ignore_nil!
json.ride do
  from = @ride.route.location_a
  to = @ride.route.location_b

  json.id @ride.id
  json.available_seats @ride.available_seats
  json.scheduled_datetime @ride.scheduled_datetime.strftime("%A, %B %-d %Y at %H:%M")
  json.route do
    json.from do
      json.latitude from.latitude
      json.longitude from.longitude
    end
    json.to do
      json.latitude to.latitude
      json.longitude to.longitude
    end
    json.drop_points do
      json.array! @ride.drop_points do |drop_point|
        json.latitude drop_point.location.latitude      
        json.longitude drop_point.location.longitude
      end
    end
  end
  json.driver do
    json.full_name @ride.user_owner.full_name
    json.rating @ride.user_owner.total_rating
  end
end