require 'rails_helper'

RSpec.describe Log, type: :model do
  it "requires a query" do
    log = Log.new(ip_address: '192.168.1.1')
    expect(log).not_to be_valid
    expect(log.errors[:query]).to include("can't be blank")
  end

  it "requires an IP address" do
    log = Log.new(query: 'search query')
    expect(log).not_to be_valid
    expect(log.errors[:ip_address]).to include("can't be blank")
  end

  it 'search_by_title returns logs with a matching query' do
    log1 = create(:log, query: 'search query', ip_address: '192.168.1.1')
    result = Log.search_by_title('search query')
    expect(result).to include(log1)
  end

  it 'search_by_title returns no logs with a non-matching query' do
    log1 = create(:log, query: 'search query', ip_address: '192.168.1.1')
    result = Log.search_by_title('non-matching query')
    expect(result).to be_empty
  end
end
