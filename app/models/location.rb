class Location < ApplicationRecord
  has_one :route, :class_name => 'Route', :foreign_key => 'location_a_id'
end
