class Admin::Authors::Index::AuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :photo

  def photo
    object.photo_url
  end
end
