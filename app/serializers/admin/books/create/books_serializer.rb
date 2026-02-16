class Admin::Books::Create::BooksSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :author_id, :release_date, :photo

  def photo
    object.photo_url
  end
end
