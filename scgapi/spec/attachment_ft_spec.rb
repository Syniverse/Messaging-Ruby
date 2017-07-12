require 'rspec'
require_relative '../scgapi.rb'
require_relative 'support/common.rb'

describe 'Attachment' do
  include_context 'setup'

  before(:all) do
    init_globals
    @aid_val = @api_client.attachments.create({'name' => 'test_upload',
                                                'type' => 'image/jpeg',
                                                'filename' => 'cutecat.jpg'})['id']
  end

  let(:res) {
    @api_client.attachments
  }

  let(:att_id) do
    @aid_val
  end

  let(:tmpname) do
    Dir::Tmpname.create(['a', '.png']) { }
  end

  let(:tmpfile) do
    File.open(tmpname, 'w') { |file| file.write("test data") }
    tmpname
  end

  describe '.create' do
    it 'has a id' do
      expect(att_id).to be_kind_of(String)
    end
  end

  describe '.get' do
    it 'fetches an object' do
      result = res.get(att_id)['id']
      expect(result). to eq(att_id)
    end
  end

  describe '.list' do
    it "lists attachments" do
      num = 0
      res .list.each {|c| num += 1; break }
      expect(num).to satisfy{|v| v > 0}
    end
  end

  describe '.upload' do
    it 'does not fail to upload' do
      result = res.upload att_id, tmpfile
      expect(result).to be_nil
    end
  end

  describe '.delete' do
    it 'does not exist after delete' do
      res.delete(att_id)
      expect {res.get(att_id)}.to raise_error(RestClient::NotFound)
    end
  end

  after do
    File.delete(tmpname) if File.exist?(tmpname)
  end

end

