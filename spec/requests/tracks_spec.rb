require 'rails_helper'

RSpec.describe 'Tracks', type: :request do
  let!(:user) { create(:user) }
  let(:user_id) { user.id }
  let!(:activity) { create(:activity) }
  let(:activity_id) { activity.id }
  let!(:tracks) { create_list(:track, 10, activity_id: activity.id) }
  let(:id) { tracks.first.id }
  let(:headers) { valid_headers }

  describe 'GET /activities/:activity_id/tracks' do
    before { get "/activities/#{activity_id}/tracks", params: {}, headers: headers }

    context 'when activity exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all activity`s tracks' do
        expect(json.size).to eq(10)
      end
    end

    context 'when this activity has tracks' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when activity does not exist' do
      let(:activity_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).not_to match(/Couldn't find the Activity/)
      end
    end
  end

  describe 'GET /activities/:activity_id/tracks/:id' do
    before { get "/activities/#{activity_id}/tracks/#{id}", params: {}, headers: headers }

    context 'when the activity`s track exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the track' do
        expect(json['id']).to eq(id)
      end

    end
    context 'when the activity`s track does not exist' do
      let(:id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Track/)
      end
    end
  end

  describe 'POST /activities/:activity_id/tracks' do
    let(:valid_attributes) do
      { track: { name: 'Lorem', duration: '30', distance: '1000', completed: 'no', activity_id: activity_id }.to_json }
    end

    context 'when request attributes are valid' do
      before { post "/activities/#{activity_id}/tracks", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/activities/#{activity_id}/tracks", params: { }, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank, Day can't be blank/)
      end
    end
  end

  describe 'PUT /activities/:activity_id/tracks/:id' do
    let(:valid_attributes) { { date: '2021-12-12' }.to_json  }

    before { put "/activities/#{activity_id}/tracks/#{id}", params: valid_attributes, headers: headers }

    context 'when track exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the track' do
        updated_track = Track.find(id)
        expect(updated_track.date).to eq('2021-12-12')
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

  describe 'DELETE /activities/:activity_id/tracks/:id' do
    before { delete "/activities/#{activity_id}/tracks/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
