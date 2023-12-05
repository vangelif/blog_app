require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'returns http success' do
      get '/users'
      expect(response).to have_http_status(:success)
    end
    it 'returns success response 200' do
      get '/users'
      expect(response.status).to eq(200)
    end
    it 'returns body within the page' do
      get '/users'
      expect(response.body).to include('Find me in')
    end
  end

  describe 'GET /users/:id' do
    it 'returns http success' do
      get '/users/:id'
      expect(response).to have_http_status(:success)
    end
    it 'returns success response 200' do
      get '/users/:id'
      expect(response.status).to eq(200)
    end
    it 'returns body within the page' do
      get '/users/:id'
      expect(response.body).to include('Users#show')
    end
  end
end
