require 'rails_helper'

RSpec.describe LogsController, type: :controller do
  describe 'POST #search' do
    let(:ip_address) { '192.168.1.1' }

    context 'when the search query is completed' do
      let(:search_query) { 'completed query' }

      before do
        allow(controller).to receive(:query_completed?).and_return(true)
        allow(request).to receive(:remote_ip).and_return(ip_address)
      end

      it 'logs the completed search query' do
        expect { post :search, params: { searchquery: search_query }, format: :json }
          .to change { Log.count }.by(1)

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['message']).to eq('Search query processed.')
      end
    end

    context 'when the search query is not completed' do
      let(:search_query) { 'incomplete query' }

      before do
        allow(controller).to receive(:query_completed?).and_return(false)
        allow(request).to receive(:remote_ip).and_return(ip_address)
      end

      it 'does not create logs for unfinished queries' do
        expect { post :search, params: { searchquery: search_query }, format: :json }
          .to change { Log.count }.by(0)

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['message']).to eq('Search query processed.')
      end
    end
  end
end
