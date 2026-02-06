class Admin::AuthorsController < ApplicationController
  def index
    authors = Author.all

    render json: authors,
           each_serializer: Index::AuthorSerializer,
           status: :ok
  end

  def create
    author = Author.create!(author_params)

    render json: author,
           serializer: Create::AuthorSerializer,
           status: :created
  end

  def update
    author = Author.find(params[:id])

    author.update!(author_params)

    head :no_content
  end

  def show
    author = Author.find(params[:id])

    render json: author,
           serializer: Show::AuthorSerializer,
           status: :ok
  end

  def destroy
    author = Author.find(params[:id])

    author.destroy!

    head :no_content
  end

  private

  def author_params
    params.require(:author).permit(:name)
  end
end
