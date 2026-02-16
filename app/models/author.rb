class Author < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :books, dependent: :destroy

  has_one_attached :photo

  validates :name, presence: true

  def photo_url
    if self.photo.attached?
      "#{ENV['BASE_URL']}#{rails_blob_path(self.photo, only_path: true)}"
    end
  end
end
