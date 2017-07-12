shared_context 'setup' do

  def init_globals
    @test_setup = JSON.parse(File.read(ENV['SPEC_SETUP']))
    @url = @test_setup['url'] ? @test_setup['url'] : "https://api.syniverse.com"
    @factory = Scg::Factory.new({'api_addr' => @url});
    @authenticator = @factory.buildAuthenticator(json_config: ENV['SPEC_AUTH'])
    @api_client = @factory.buildApiClient(@authenticator)
  end
end