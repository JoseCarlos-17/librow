class Book < ApplicationRecord
  belongs_to :author

  has_one_attached :photo

  validates :title, :description, :release_date, :author_id, presence: true
end
