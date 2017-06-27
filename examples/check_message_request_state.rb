require_relative '../scgapi/scgapi.rb'

def check_state(mrqId, url_arg = {})
  factory = Scg::Factory.new(url_arg);
  authenticator = factory.buildAuthenticator(json_config: 'auth.json' )
  api_client = factory.buildApiClient(authenticator)

  res = api_client.message_requests

  puts res.get mrqId
end

if !ARGV[0]
  puts 'Usage: check_message_request_state.rb request_id [api-url]'
  exit -1
end

url_arg = ARGV[1] ? {'api_addr' => ARGV[1]} : {}
check_state ARGV[0], url_arg

