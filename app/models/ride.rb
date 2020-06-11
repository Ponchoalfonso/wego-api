class Ride < ApplicationRecord
  belongs_to :user_owner, :class_name => 'User'
  belongs_to :route
  has_many :passengers
  has_many :users, through: :passengers
end
