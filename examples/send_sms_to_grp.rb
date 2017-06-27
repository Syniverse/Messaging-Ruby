require_relative '../scgapi/scgapi.rb'

def send_sms(senderid, bob_mdm, alice_mdn, url_arg = {})
  factory = Scg::Factory.new(url_arg);
  authenticator = factory.buildAuthenticator(json_config: 'auth.json' )
  api_client = factory.buildApiClient(authenticator)

  # Create Bob
  contact_res = api_client.contacts
  bob_id = contact_res.create(
      {'first_name' =>'Bob',
       'primary_mdn' => bob_mdm})['id']

  # Create Alice
  contact_res = api_client.contacts
  alice_id = contact_res.create(
      {'first_name' =>'Alice',
       'primary_mdn' => alice_mdn})['id']

  group_res = api_client.contact_groups
  friends_id = group_res.create({'name' => 'Our Friends'})['id']
  group_res.add_contacts(friends_id, [bob_id, alice_id])

  mrq_res = api_client.message_requests
  request_id = mrq_res.create({'from' => 'sender_id:' + senderid,
                           'to' =>['group:' + friends_id],
                           'body' => 'Hello World'})['id']

  puts "Created message request #{request_id}"

  group_res.delete friends_id
  contact_res.delete(bob_id)
  contact_res.delete(alice_id)
end

if !ARGV[0] || !ARGV[1] || !ARGV[2]
  puts 'Usage: send_sms_to_grp.rb senderid bob_mdn alice_mdn [api-url]'
  exit -1
end

url_arg = ARGV[3] ? {'api_addr' => ARGV[3]} : {}
send_sms ARGV[0], ARGV[1], ARGV[2], url_arg

