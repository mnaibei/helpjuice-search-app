require 'rails_helper'

RSpec.describe LogsController, type: :request do
    let(:ip_address) { '192.168.1.1' }

    before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:remote_ip).and_return(ip_address)
    end

    describe 'POST #search' do
        context 'with a completed search query' do
            it 'logs the search query' do
                post '/logs/search', params: { searchquery: 'query 0' }

                expect(response).to have_http_status(:success)
                expect(Log.where(ip_address: ip_address).count).to eq(1)
            end
        end
        context 'with an incomplete search query' do
            it 'logs the search query' do
                post '/logs/search', params: { searchquery: 'query ' }

                expect(response).to have_http_status(:success)
                expect(Log.where(ip_address: ip_address).count).to eq(1)
            end
        end
    end

    describe 'GET #history' do
        it 'returns the history of completed search queries for the current IP address' do
            Log.create(query: "query 0", ip_address: ip_address)

            get '/logs/history'

            expect(response).to have_http_status(:success)
            parsed_response = JSON.parse(response.body)
            expect(parsed_response['history']).to contain_exactly('query 0')
        end
    end
end