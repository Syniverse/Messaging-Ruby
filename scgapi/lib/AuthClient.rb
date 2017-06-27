module Scg

    module Auth

        class Client
            def initialize(options)
                @requester = Scg::Api::Requester.new(options['base_url'],
                                                     Scg::Api::JsonPayloadReader.new(),
                                                     Scg::Api::JsonPayloadWriter.new(),
                                                     options['http'])
            end

            def refresh_token(token, consumer_key, consumer_secret)
                params = {
                    'consumerkey' => consumer_key,
                    'consumersecret' => consumer_secret,
                    'oldtoken' => token
                }
                return @requester.request(:method => :get, :path => 'apptoken-refresh', :params => params)['accessToken']
            end
        end

    end # module Auth

end # module Scg
