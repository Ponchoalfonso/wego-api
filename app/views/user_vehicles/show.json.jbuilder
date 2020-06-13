json.ignore_nil!
json.vehicle do
  json.extract! @vehicle, :brand, :model, :plate_code, :color
  json.picture_url @vehicle.picture_url
end