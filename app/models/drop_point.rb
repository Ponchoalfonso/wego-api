class DropPoint < ApplicationRecord
  belongs_to :route
  belongs_to :location
  has_many :passangers
  has_many :users, through: :passengers
end
