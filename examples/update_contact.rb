require_relative '../scgapi/scgapi.rb'

def update_contact(url_arg = {})
  factory = Scg::Factory.new(url_arg);
  authenticator = factory.buildAuthenticator(json_config: 'auth.json' )
  api_client = factory.buildApiClient(authenticator)

  res = api_client.contacts

  cid = res.create(
      {'first_name' =>'John',
       'last_name' => 'Doe',
       'primary_mdn' => '3592884111115'})['id']

  contact = res.get(cid)

  res.update(cid, {'last_name' => 'Anderson',
                   'version_number' => contact['version_number']})

  contact = res.get(cid)
  puts "John Doe changed name to #{contact['first_name']} #{contact['last_name']}"
  res.delete(cid)
end

url_arg = ARGV[0] ? {'api_addr' => ARGV[0]} : {}

update_contact url_arg