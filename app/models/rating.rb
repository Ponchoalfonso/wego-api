class Rating < ApplicationRecord
  belongs_to :user_owner_id, :class_name => 'User'
  belongs_to :user_passanger, :class_name => 'User'
end
