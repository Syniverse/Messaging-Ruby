require 'rspec'
require_relative '../scgapi.rb'
require_relative 'support/common.rb'

describe 'Channel' do
  include_context 'setup'


  before(:all) do
    init_globals
    @mrq = @api_client.message_requests.create(
        {
          'from'=>"sender_id:#{@test_setup['senderIdSms']}",
          'to'=>[@test_setup['mdnRangeStart']],
          'body'=>'Hello world',
          'test_message_flag'=>true
        })['id']
  end

  let(:res) do
    @api_client.message_requests
  end

  let(:message_request) do
    res.get(@mrq)
  end


  describe '.create' do
    it 'has a id' do
      expect(@mrq).to be_kind_of(String)
    end
  end

  describe '.get' do
    it 'can be fetched with it\'s id' do
      expect(message_request['id']).to eq @mrq
    end
  end

  describe '.list' do
    it "contains message request" do
      num = 0
      res .list.each {|c| num += 1; break }
      expect(num).to satisfy{|v| v > 0}
    end
  end

  describe '.delete' do
    it 'does not exist after delete' do
      res.delete(@mrq)
      expect {res.get(@mrq)}.to raise_error(RestClient::NotFound)
    end
  end
end

