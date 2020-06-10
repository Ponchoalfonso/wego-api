class User < ApplicationRecord
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