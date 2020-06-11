class Location < ApplicationRecord
  has_one :route, :class_name => 'Route', :foreign_key => 'location_a_id'
  has_one :drop_point

  acts_as_mappable :default_units => :kms,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude
end
