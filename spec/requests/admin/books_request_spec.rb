require 'rails_helper'

RSpec.describe 'Books', type: :request do
  let(:photo) { fixture_file_upload("app/assets/images/cover.png", "file/png") }
  let(:author) { create(:author) }
  let(:book) { create(:book, author_id: author.id, photo: photo) }

  describe 'POST#create' do
    context 'when a book is created' do
      let(:photo) { fixture_file_upload("app/assets/images/cover.png", "file/png") }
      let(:book_params) { attributes_for(:book, author_id: author.id,
        photo: photo) }

      before do
        post '/admin/books', params: { book: book_params }
      end

      it 'must return 201 status code' do
        expect(response).to have_http_status(:created)
      end

      it 'must return book created attributes' do
        expect(json_body).to include(:title, :description, :author_id,
                                     :release_date)
      end
    end

    context 'when a invalid param is passed' do
      let(:invalid_book_params) {
        attributes_for(:book, title: nil, author_id: nil, description: nil,
                              release_date: nil)
      }

      before do
        post '/admin/books', params: { book: invalid_book_params }
      end

      it 'must return 422 status code' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'must return errors messages' do
        expect(json_body).to have_key(:errors)
      end
    end
  end

  describe 'GET#show' do
    context 'when a book is selected' do
      before do
        get "/admin/books/#{book.id}"
      end

      it 'must return 200 status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'must return book selected attributes' do
        expect(json_body).to include(:title, :description, :author_id,
                                     :release_date)
      end
    end
  end

  describe 'PUT#update' do    
    context 'when a chosed book is updated' do
      let(:book_params) { attributes_for(:book, title: 'mystring2') }

      before do
        put "/admin/books/#{book.id}", params: { book: book_params }
      end

      it 'must return 204 status code' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when a invalid data is passed' do
      let (:invalid_book_params) { attributes_for(:book, title: '') }

      before do
        put "/admin/books/#{book.id}", params: { book: invalid_book_params }
      end

      it 'must return 422 status code' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'must return the message error' do
        expect(json_body).to have_key(:errors)
      end
    end
  end

  describe 'GET#index' do
    context 'when there are books to be listed' do
      let(:books) { create_list(:book, 3, author_id: author.id) }

      before do
        books

        get '/admin/books'
      end

      it 'must return 200 status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'must return book attributes' do
        expect(json_body[0]).to include(:title, :description, :author_id,
                                        :release_date)
      end
    end
  end

  describe 'DELETE#destroy' do
    context 'when a book is deleted' do
      before do
        book
        delete "/admin/books/#{book.id}"
      end

      it 'must return 204 status code' do
        expect(response).to have_http_status(:no_content)
      end

      it 'must verify if the book was removed' do
        expect(Book.count).to eq(0)
      end
    end
  end
end
