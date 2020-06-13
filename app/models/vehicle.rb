class Vehicle < ApplicationRecord
  belongs_to :user
  has_one_attached :picture

  def picture_url
    if self.picture.attached?
      Rails.application.routes.url_helpers.rails_blob_path(self.picture, only_path: true)
    else
      nil
    end
  end
end
