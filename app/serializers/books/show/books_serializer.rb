class Books::Show::BooksSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :author_id, :release_date
end
