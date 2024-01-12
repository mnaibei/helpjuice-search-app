require 'rails_helper'

RSpec.describe LogsController, type: :controller do
  describe 'POST #search' do
    it 'creates a log entry and renders a JSON response' do
      post :search, params: { searchquery: 'test query' }

      expect(response).to have_http_status(:success)
      expect(response.body).to include('Search query logged.')

      log = Log.last
      expect(log.query).to eq('test query')
      expect(log.ip_address).to eq(request.remote_ip)
    end
  end
end
