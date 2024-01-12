require 'rails_helper'

RSpec.describe Log, type: :model do
  it 'is valid with valid attributes' do
    log = Log.new(query: 'test query', ip_address: '127.0.0.1')
    expect(log).to be_valid
  end

  it 'is not valid without a query' do
    log = Log.new(ip_address: '127.0.0.1')
    expect(log).to_not be_valid
    expect(log.errors[:query]).to include("can't be blank")
  end

  it 'is not valid without an ip_address' do
    log = Log.new(query: 'test query')
    expect(log).to_not be_valid
    expect(log.errors[:ip_address]).to include("can't be blank")
  end
end
