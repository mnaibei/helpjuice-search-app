require 'rails_helper'

RSpec.describe SearchAnalyticsController, type: :controller do
  describe 'GET #index' do
    it 'returns search analytics in JSON format' do
      logs = [
        Log.create(query: 'query1', ip_address: '127.0.0.1'),
        Log.create(query: 'query2', ip_address: '127.0.0.2'),
        Log.create(query: 'query3', ip_address: '127.0.0.1'),
      ]

      get :index

      expect(response).to have_http_status(:success)

      # Parse the JSON response and verify its structure
      json_response = JSON.parse(response.body)
      expect(json_response).to be_an(Array)

      # Verify the content of the response
      expect(json_response.length).to eq(3)
      end
    end
  end
