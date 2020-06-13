json.ignore_nil!
json.ride do
  vehicle = nil
  passengers = nil
  desired_drop_point = nil

  from = @ride.route.location_a
  to = @ride.route.location_b

  if @app_type == 'Customers'
     vehicle = @ride.user_owner.vehicle
  elsif @app_type == 'Drivers'
    passengers = @ride.passengers
  end

  if @app_type == 'Drivers' or @app_type == 'Customers'
    if current_user.reserved_ride?(@ride)
      desired_drop_point = @ride.passengers.where(user: current_user).first.drop_point.location
    end
  end

  json.id @ride.id
  json.total_seats @ride.seats
  json.occupied_seats @ride.occupied_seats
  json.available_seats @ride.available_seats
  json.scheduled_datetime @ride.scheduled_datetime.strftime("%A, %B %-d %Y at %H:%M")
  json.departure_datetime @ride.departure_datetime&.strftime("%A, %B %-d %Y at %H:%M")
  json.finished_datetime @ride.finished_datetime&.strftime("%A, %B %-d %Y at %H:%M")
  json.finished @ride.finished
  json.total_price @ride.total_price
  json.route do
    json.from do
      json.latitude from.latitude
      json.longitude from.longitude
    end
    json.to do
      json.latitude to.latitude
      json.longitude to.longitude
    end
    if !desired_drop_point.nil?
      json.desired_drop_point do
        json.extract! desired_drop_point, :latitude, :longitude
      end
    end
    json.drop_points do
      json.array! @ride.drop_points do |drop_point|
        json.latitude drop_point.location.latitude      
        json.longitude drop_point.location.longitude
      end
    end
  end
  if @app_type == 'Customers'
    json.driver do
      json.full_name @ride.user_owner.full_name
      json.rating @ride.user_owner.total_rating
      if !vehicle.nil?
        json.vehicle do
          json.extract! vehicle, :brand, :model, :plate_code, :color
          json.picture vehicle.picture_url
        end
      end
    end
  end
  if !passengers.nil?
    json.passengers do
      json.array! passengers do |passenger|      
        json.full_name passenger.user.full_name
        json.reserved_seats passenger.reserved_seats
        json.profile_picture passenger.user.profile_picture_url
      end
    end
  end
end