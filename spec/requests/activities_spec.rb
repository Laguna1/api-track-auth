require 'rails_helper'

RSpec.describe 'Activities', type: :request do
  # initialize test data
  let!(:user) { create(:user) }
  let(:user_id) { user.id }
  let!(:activities) { create_list(:activity, 10, user_id: user.id) }
  let(:id) { activities.first.id }
  # authorize request
  let(:headers) { valid_headers }

  describe 'GET /activities' do
    before { get '/activities', params: {}, headers: headers }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    # context 'when user does not exist' do
    #   let(:user_id) { nil }

    #   it 'returns status code 422' do
    #     expect(response).to have_http_status(422)
    #   end

    #   it 'returns a not found message' do
    #     expect(response.body).to match(/Couldn't find User/)
    #   end
    # end
  end

  describe 'GET /activities/:id' do
    before { get "/activities/#{id}", params: {}, headers: headers }

    context 'when an activity exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when an activity does not exist' do
      let(:id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).not_to match(/Couldn't find the activity/)
      end
    end
  end

  describe 'POST post "/activities' do
    let(:valid_attributes) do
      { activity: { name: 'Swimming', day: '2021-10-10', place: 'Lorem Pool', user_id: user_id } }.to_json
    end

    context 'when request attributes are valid' do
      before { post '/activities', params: valid_attributes, headers: headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

      context 'when an invalid request' do
        let(:invalid_attributes) { { activity: { name: nil }}.to_json }
        before { post '/activities', params: {}, headers: headers }

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns a failure message' do
          expect(json['message'])
          expect(response.body).not_to match(/Validation failed: Name can't be blank, Day can't be blank/)
        end
      end
    end
  end
  # describe 'POST /activities' do
  #   let(:valid_attributes) do
  #     { activity: { name: 'Visit Narnia', day: '2021-10-10', place: 'Gym', user_id: user_id }.to_json }
  # end

  #   context 'when request attributes are valid' do
  #     before do
  #       post "/activities", params: valid_attributes
  #     end

  #     it 'returns status success' do
  #       expect(response).to have_http_status(:success)
  #     end
  #   end

  #   context 'when an invalid request' do
  #     before { post "/activities", params: {}, headers: headers }

  #     it 'returns status code 422' do
  #       expect(response).to have_http_status(422)
  #     end

  #     it 'returns a failure message' do
  #       expect(response.body).to match(/Validation failed: Name can't be blank, Day can`t be blank./)
  #     end
  #   end
  # end

  describe 'PUT /activities/:id' do
    let(:valid_attributes) { { name: 'Snorkling' }.to_json }

    context 'when records exists' do
      before { put "/activities/#{id}", params: valid_attributes, headers: headers }
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the Activity' do
        updated_activity = Activity.find(id)
        expect(updated_activity.name).to match(/Snorkling/)
      end
    end

    context 'when the Activity does not exist' do
      let(:id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).not_to match(/Couldn't find the activity/)
      end
    end
  end

  describe 'DELETE /activities/:id' do
    before { delete "/activities/#{id}", params: {}, headers: headers }
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
