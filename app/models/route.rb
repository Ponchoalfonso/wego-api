class Route < ApplicationRecord
  belongs_to :location_a, :class_name => 'Location'
  belongs_to :location_b, :class_name => 'Location'
end
