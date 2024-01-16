FactoryBot.define do
    factory :log do
      query { 'Test query' }
      ip_address { '192.168.1.1' }
    end
  end
  