class Book < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :author

  has_one_attached :photo

  validates :title, :description, :release_date, :author_id, presence: true

  def photo_url
    if self.photo.attached?
      "#{ENV['BASE_URL']}#{rails_blob_path(self.photo, only_path: true)}"
    end
  end
end
