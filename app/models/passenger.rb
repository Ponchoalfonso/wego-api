class Passenger < ApplicationRecord
  belongs_to :ride
  belongs_to :user
  belongs_to :drop_point
end
