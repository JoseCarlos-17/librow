require 'rails_helper'
require 'support/request_helper_spec'

RSpec.describe "Authors", type: :request do
  describe "GET #index" do
    context 'when the author list is returned' do
      it 'must return 200 status code' do
        author = create_list(:author, 2)

        get '/authors'

        expect(response).to have_http_status(:ok)
      end

      it 'must return the author list' do
        authors = create_list(:author, 2)

        get '/authors'

        expect(json_body[0]).to have_key(:id)
        expect(json_body[0]).to have_key(:name)
        expect(json_body[0]).to have_key(:articles)
      end
    end
  end

  describe 'POST #create' do
    context 'when the author is created' do
      it 'must return 201 status code' do
        author_params = attributes_for(:author, name: 'Stephen King')

        post '/authors', params: { author: author_params }

        expect(response).to have_http_status(:created)
      end

      it 'must create the author' do
        author_params = attributes_for(:author, name: 'Stephen King')

        post '/authors', params: { author: author_params }

        expect(json_body).to have_key(:id)
        expect(json_body).to have_key(:name)
      end
    end

    context 'when the author is not created' do
      it 'must return 422 status code' do
        author_params = attributes_for(:author, name: nil)

        post '/authors', params: { author: author_params }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'must return the error message' do
        author_params = attributes_for(:author, name: nil)

        post '/authors', params: { author: author_params }

        expect(json_body).to have_key(:error_message)
      end
    end
  end

  describe 'PUT #update' do
    context 'when the author is updated' do
      it 'must return the 204 status code' do
        author = create(:author)
        author_params = attributes_for(:author, name: 'Mary Shelley')

        put "/authors/#{author.id}", params: { author: author_params }

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the author is not updated' do
      it 'must return the 422 status code' do
        author = create(:author)
        author_params = attributes_for(:author, name: nil)

        put "/authors/#{author.id}", params: { author: author_params }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #show' do
    context 'when the author is found' do
      it 'must return 200 status code' do
        author = create(:author, name: 'Edgar Allan Poe')

        get "/authors/#{author.id}"

        expect(response).to have_http_status(:ok)
      end

      it 'must return the author' do
        author = create(:author, name: 'Edgar Allan Poe')

        get "/authors/#{author.id}"

        expect(json_body).to have_key(:id)
        expect(json_body).to have_key(:name)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when the author is deleted' do
      it 'must return 204 status code' do
        author = create(:author, name: 'Rick Riordan')

        delete "/authors/#{author.id}"

        expect(response).to have_http_status(:no_content)
      end

      it 'must delete the author' do
        author = create(:author, name: 'Rick Riordan')

        delete "/authors/#{author.id}"

        expect(Author.count).to eq(0)
      end
    end
  end
end
