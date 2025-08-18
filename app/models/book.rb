class Book < ApplicationRecord
  belongs_to :author

  validates :title, :description, :release_date, :author_id, presence: true
end
