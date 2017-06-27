require_relative '../scgapi/scgapi.rb'

def send_mms(senderid, mdn, attachment, url_arg = {})
  factory = Scg::Factory.new(url_arg);
  authenticator = factory.buildAuthenticator(json_config: 'auth.json' )
  api_client = factory.buildApiClient(authenticator)

  att_res = api_client.attachments

  att_id = att_res.create({'name' => 'test_upload',
                           'type' => 'image/jpeg',
                           'filename' => 'cutecat.jpg'})['id']

  att_res.upload att_id, attachment

  mrq_res = api_client.message_requests
  request_id = mrq_res.create({'from' => 'sender_id:' + senderid,
                               'to' =>[mdn],
                               'attachments' => [att_id],
                               'body' => 'Hello World'})['id']

  puts "Created message request #{request_id}"
end

if !ARGV[0] || !ARGV[1] || !ARGV[2]
  puts 'Usage: send_mms.rb senderid receipient attachment [api-url]'
  exit -1
end

url_arg = ARGV[2] ? {'api_addr' => ARGV[3]} : {}
send_mms ARGV[0], ARGV[1], ARGV[2], url_arg

