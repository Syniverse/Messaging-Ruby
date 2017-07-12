require 'rspec'
require_relative '../scgapi.rb'
require_relative 'support/common.rb'

describe 'ContactResource' do
  include_context 'setup'

  before(:all) do
    init_globals
    @uid_val = @api_client.contacts.create(
        {'first_name' => 'test',
         'last_name' => 'User',
         'primary_mdn' => @test_setup['mdnRangeStart']})['id']
  end

  let(:res) {
    @api_client.contacts
  }

  describe 'create list update and delete' do

    let(:uid) do
      @uid_val
    end

    let(:contact) do
      res.get(uid)
    end

    let (:updated) do
      res.update(uid, {'first_name' => 'Testing',
                       'version_number' => contact['version_number']})
      res.get(uid)
    end

    describe '.create' do
      it 'has a id' do
        expect(uid).to be_kind_of(String)
      end
    end

    describe '.get' do
      it 'can be fetched with it\'s id' do
        expect(contact['id']).to eq uid
      end
    end

    describe '.list' do
      it "contains contacts" do
        num = 0
        res .list.each {|c| num += 1; break }
        expect(num).to satisfy{|v| v > 0}
      end
    end

    describe '.update' do
      it 'can update a property' do
        expect(updated['first_name']).to eq 'Testing'
      end
    end

    describe '.delete' do
      it 'does not exist after delete' do
        res.delete(uid)
        expect {res.get(uid)}.to raise_error(RestClient::NotFound)
      end
    end
  end
end

