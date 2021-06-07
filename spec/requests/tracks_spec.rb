require 'rails_helper'

RSpec.describe "Tracks", type: :request do
  # Initialize the test data
  let(:user) { create(:user) }
  let(:user_id) { user.id }
  let!(:activity) { create(:activity, user.id) }
  let!(:tracks) { create_list(:track, 20, activity_id: activity.id) }
  let(:activity_id) { activity.id }
  let(:id) { tracks.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /activities/:activity_id/tracks
  describe 'GET /activities/:activity_id/tracks' do
    before { get "/activities/#{activity_id}/tracks", params: {}, headers: headers }

    context 'when activity exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all activity tracks' do
        expect(json.size).to eq(20)
      end
    end

    context 'when activity does not exist' do
      let(:activity_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Activity/)
      end
    end
  end

  # Test suite for GET /activities/:activity_id/tracks/:id
  describe 'GET /activities/:activity_id/tracks/:id' do
    before { get "/activities/#{activity_id}/tracks/#{id}", params: {}, headers: headers }

    context 'when activity track exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the track' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when activity track does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Track/)
      end
    end
  end

  # Test suite for POST /activities/:activity_id/tracks
  describe 'POST /activities/:activity_id/tracks' do
    let(:valid_attributes) { { name: 'Visit Narnia', done: false }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/activities/#{activity_id}/tracks", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/activities/#{activity_id}/tracks", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /activities/:activity_id/tracks/:id
  describe 'PUT /activities/:activity_id/tracks/:id' do
    let(:valid_attributes) { { name: 'Mozart' }.to_json }

    before do 
      put "/activities/#{activity_id}/tracks/#{id}", params: valid_attributes, headers: headers
    end

    context 'when track exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the track' do
        updated_track = Track.find(id)
        expect(updated_track.name).to match(/Mozart/)
      end
    end

    context 'when the track does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Track/)
      end
    end
  end

  # Test suite for DELETE /activities/:id
  describe 'DELETE /activities/:id' do
    before { delete "/activities/#{activity_id}/tracks/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
