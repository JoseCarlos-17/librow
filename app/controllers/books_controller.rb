class BooksController < ApplicationController
  before_action :find_book, only: %i[show destroy]

  def create
    book = Book.new(book_params)

    if book.save
      render json: book,
             serializer: Books::Create::BooksSerializer,
             status: :created
    else
      render json: { errors: book.errors }, status: :unprocessable_entity
    end
  end

  def show
    render json: find_book,
           serializer: Books::Show::BooksSerializer,
           status: :ok
  end
  
  def update
    book = Book.find(params[:id])

    if book.update(book_params)
      head :no_content
    else
      render json: { errors: book.errors }, status: :unprocessable_entity
    end
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
