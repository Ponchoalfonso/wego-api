class User < ApplicationRecord
  has_one :address
  belongs_to :role
  has_one_attached :profile_picture
  has_many :owned_rides, :class_name => 'Ride', :foreign_key => 'user_owner_id'
  has_many :passengers
  has_many :rides, through: :passengers
  has_many :routes, through: :rides, :foreign_key => 'user_owner_id'
  has_one :vehicle
  has_many :passengers_ratings, :class_name => 'Rating', :foreign_key => 'user_passenger_id'
  has_many :ratings, :class_name => 'Rating', :foreign_key => 'user_owner_id'
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  def jwt_payload
    { 
      'id' => self.id,
      'email' => self.email,
      'full_name' => self.full_name
    }
  end

  def full_name
    "#{self.name} #{self.last_name} #{self.second_last_name} ".strip!
  end

  def total_rating
    rating = self.ratings.average(:score)
    rating.nil? ? 0 : rating
  end

  def reserved_ride?(ride)
    self.rides.include?(ride)
  end

  def profile_picture_url
    if self.profile_picture.attached?
      Rails.application.routes.url_helpers.rails_blob_path(self.profile_picture, only_path: true)
    else
      nil
    end
  end
end