require 'rails_helper'

RSpec.describe "Activities", type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let(:user_id) { user.id }
  let!(:activities) { create_list(:activity, 10) }
  let(:activity_id) { activities.first.id }
  #  authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /todos
  describe 'GET /activities' do
    # make HTTP get request before each example
    before { get '/activities', params: {}, headers: headers }

    it 'returns activities' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /todos/:id
  describe 'GET /activities/:id' do
    before { get "/activities/#{activity_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the activity' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(activity_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:activity_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Activity/)
      end
    end
  end

  # Test suite for POST /activities
  describe 'POST /activities' do
    # send json payload
    let(:valid_attributes) do
      { user_id: 1, name: 'Fitness', day: '2021-08-05' }.to_json
    end

    context 'when the request is valid' do
      before { post '/activities', params: valid_attributes, headers: headers }

      it 'creates an activity' do
        expect(json['name']).to eq('Fitness')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { name: nil }.to_json }
      before { post '/activities', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: User must exist, Name can't be blank, Day can't be blank/)
      end
    end
  end

  # Test suite for PUT /activities/:id
  describe 'PUT /activities/:id' do
    let(:valid_attributes) { { name: 'Cycling' }.to_json }

    context 'when the record exists' do
      before { put "/activities/#{activity_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /activities/:id
  describe 'DELETE /activities/:id' do
    before { delete "/activities/#{activity_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
