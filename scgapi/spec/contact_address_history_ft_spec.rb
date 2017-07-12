require 'rspec'
require_relative '../scgapi.rb'
require_relative 'support/common.rb'

describe 'ContactAddressHistoryResource' do
  include_context 'setup'

  before(:all) do
    init_globals
  end

  let(:res) {
    @api_client.contact_address_history
  }

  describe ".list" do
    it "is not empty" do
      num = 0
      res .list.each {|c| num += 1; break }
      expect(num).to satisfy{|v| v > 0}
    end
  end

end

