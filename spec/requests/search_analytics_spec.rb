require 'swagger_helper'

RSpec.describe 'search_analytics', type: :request do

  path '/search_analytics' do

    get('list search_analytics') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
