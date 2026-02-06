class Admin::BooksController < ApplicationController
  before_action :find_book, only: %i[show destroy]

  def create
    book = Book.create!(book_params)

    render json: book,
           serializer: Books::Create::BooksSerializer,
           status: :created
  end

  def show
    render json: find_book,
           serializer: Books::Show::BooksSerializer,
           status: :ok
  end
  
  def update
    find_book.update!(book_params)
    
    head :no_content
  end

  def index
    books = Book.includes(:author)

    render json: books,
           each_serializer: Books::Index::BooksSerializer,
           status: :ok
  end

  def destroy
    find_book.destroy

    head :no_content
  end

  private

  def book_params
    params.require(:book).permit(:title, :description, :author_id,
                                 :release_date)
  end

  def find_book
    Book.find(params[:id])
  end
end
