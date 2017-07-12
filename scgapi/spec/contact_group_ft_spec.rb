require 'rspec'
require_relative '../scgapi.rb'
require_relative 'support/common.rb'

describe 'ContactGroupResource' do
  include_context 'setup'

  before(:all) do
    init_globals
    @gid = @api_client.contact_groups.create({'name' => 'Friends'})['id']

    mdn = @test_setup['mdnRangeStart'].to_i
    @alice = @api_client.contacts.create({'first_name' => 'alice', 'primary_mdn' => mdn.to_s})['id']
    @bob = @api_client.contacts.create({'first_name' => 'bob', 'primary_mdn' => (mdn +1).to_s})['id']
  end

  after(:all) do
    @api_client.contacts.delete(@alice) if @alice
    @api_client.contacts.delete(@bob) if @bob
  end

  let(:res) {
    @api_client.contact_groups
  }
  
  let(:group) {
    res.get(@gid)
  }

  describe 'create list update add-users and delete' do

    let (:updated) do
      res.update(@gid, {'name' => 'Testing',
                       'version_number' => group['version_number']})
      res.get(@gid)
    end

    describe '.create' do
      it 'has a id' do
        expect(@gid).to be_kind_of(String)
      end
    end

    describe '.get' do
      it 'can be fetched with it\'s id' do
        expect(group['id']).to eq @gid
      end
    end

    describe '.list' do
      it "contains groups" do
        num = 0
        res .list.each {|c| num += 1; break }
        expect(num).to satisfy{|v| v > 0}
      end
    end

    describe '.update' do
      it 'can update a property' do
        expect(updated['name']).to eq 'Testing'
      end
    end

    describe '.delete' do
      it 'does not exist after delete' do
        res.delete(@gid)
        expect {res.get(@gid)}.to raise_error(RestClient::NotFound)
      end
    end
  end
end

