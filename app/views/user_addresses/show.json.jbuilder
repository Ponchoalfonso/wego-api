json.ignore_nil!
json.address do
  json.extract! @address, :country, :state, :city, :suburb, :street_address, :interior, :zip_code
end