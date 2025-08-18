class Books::Create::BooksSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :author_id, :release_date
end
