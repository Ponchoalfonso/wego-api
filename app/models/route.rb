class Route < ApplicationRecord
  belongs_to :location_a, :class_name => 'Location'
  belongs_to :location_b, :class_name => 'Location'
  has_many :drop_points
  has_many :rides
end
