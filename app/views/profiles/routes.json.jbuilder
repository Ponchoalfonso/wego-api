json.array! @routes do |route|
  json.from do
    json.extract! route.location_a, :latitude, :longitude
  end
  json.to do
    json.extract! route.location_b, :latitude, :longitude
  end
  json.drop_points do
    json.array! route.drop_points do |drop_point|
      json.extract! drop_point.location, :latitude, :longitude
    end
  end
end