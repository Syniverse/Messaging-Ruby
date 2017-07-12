require 'rspec'
require_relative '../scgapi.rb'
require_relative 'support/common.rb'

describe 'Channel' do
  include_context 'setup'

  before(:all) do
    init_globals
    @cid = @api_client.channels.create({'name' => 'CRUD channel',
                                            'description' => 'Test'})['id']
  end

  let(:res) {
    @api_client.channels
  }

  describe ".list" do
    it "lists channels" do
      num = 0
      res .list.each {|c| num += 1; break }
      expect(num).to satisfy{|v| v > 0}
    end
  end


  describe 'create update delete' do

    let(:cid) do
      @cid
    end

    let(:channel) do
      res.get(cid)
    end

    let (:updated) do
      res.update(cid, {'name' => 'Testing',
                      'version_number' => channel['version_number']})
      res.get(cid)
    end

    describe '.create' do
      it 'has a id' do
        expect(cid).to be_kind_of(String)
      end
    end

    describe '.get' do
      it 'can be fetched with it\'s id' do
        expect(channel['id']).to eq cid
      end
    end

    describe '.update' do
      it 'can update a property' do
        expect(updated['name']).to eq 'Testing'
      end
    end

    describe '.delete' do
      it 'does not exist after delete' do
        res.delete(cid)
        expect {res.get(cid)}.to raise_error(RestClient::NotFound)
      end
    end
  end
end

