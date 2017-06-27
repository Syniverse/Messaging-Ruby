require_relative '../scgapi/scgapi.rb'

def list_contacts(url_arg = {})
  factory = Scg::Factory.new(url_arg);
  authenticator = factory.buildAuthenticator(json_config: 'auth.json' )
  api_client = factory.buildApiClient(authenticator)

  # List the contacts manually, one returned data-set (page) at the time
  offset = 0
  begin
    data = api_client.contacts.list_raw({:offset => offset})
    data['list'].each {|c| puts "Contact #{c['id']} #{c['first_name']} mdn: #{c['primary_mdn']}"}
    offset += data['list'].size
  end while data['list'].size > 0

  # List the contacts conveniently, using a wrapper class that implements each()
  api_client.contacts.list.each do |c|
    puts "Contact #{c['id']} #{c['first_name']} mdn: #{c['primary_mdn']}"
  end
end

url_arg = ARGV[0] ? {'api_addr' => ARGV[0]} : {}
list_contacts url_arg
