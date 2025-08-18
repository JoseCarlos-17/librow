class Books::Index::BooksSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :author_id, :release_date
end
