class User < ApplicationRecord
  has_one :address
  belongs_to :role
  has_one_attached :profile_picture
  has_many :owned_rides, :class_name => 'Ride', :foreign_key => 'user_owner_id'
  has_many :passengers
  has_many :rides, through: :passengers
  has_many :routes, through: :rides, :foreign_key => 'user_owner_id'
  has_one :vehicle
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  def jwt_payload
    { 
      'id' => self.id,
      'email' => self.email,
      'full_name' => "#{self.name} #{self.last_name} #{self.second_last_name} ".strip!
    }
  end
end