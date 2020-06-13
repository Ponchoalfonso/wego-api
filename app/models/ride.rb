class Ride < ApplicationRecord
  belongs_to :user_owner, :class_name => 'User'
  belongs_to :route
  has_many :passengers
  has_many :users, through: :passengers
  has_many :drop_points, through: :route

  def occupied_seats
    passengers = self.passengers
    passengers.nil? ? 0 : passengers.sum(:reserved_seats)
  end

  def available_seats
    self.seats - self.occupied_seats
  end
end