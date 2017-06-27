require_relative '../scgapi/scgapi.rb'

def send_sms(senderid, mdn, url_arg = {})
  factory = Scg::Factory.new(url_arg);
  authenticator = factory.buildAuthenticator(json_config: 'auth.json' )
  api_client = factory.buildApiClient(authenticator)

  res = api_client.message_requests
  request_id = res.create({'from' => 'sender_id:' + senderid,
                           'to' =>[mdn],
                           'body' => 'Hello World'})['id']

  puts "Created message request #{request_id}"
end

if !ARGV[0] || !ARGV[1]
  puts 'Usage: send_sms.rb senderid receipient [api-url]'
  exit -1
end

url_arg = ARGV[2] ? {'api_addr' => ARGV[2]} : {}
send_sms ARGV[0], ARGV[1], url_arg

