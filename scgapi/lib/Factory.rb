module Scg

    class Factory

        def initialize(options={})
            @teste = options['api_addr']
            @api_addr = options['api_addr'] || 'https://api.syniverse.com'
            @scg_api_path = options['scg_api_path'] || '/scg-external-api/api/v1'
            @saop_api_path = options['saop_api_path'] || '/saop-rest-data/v1'
            @content_api_path = options['content_api_path'] || '/scg-attachment/api/v1'
        end

        def buildAuthClient(options={})
            return Scg::Auth::Client.new({'base_url' => @api_addr + @saop_api_path, 'http' => options })
        end

        def buildApiClient(authenticator, options={})
            return Scg::Api::Client.new(authenticator, {'base_url' => @api_addr + @scg_api_path, 'http' => options })
        end

        def buildAuthenticator(token: nil, json_config: nil)
            return Scg::Api::Authenticator.new(token: token, json_config: json_config)
        end

        def buildUploader()
        end

        def buildDownloader()
        end

    end # class Factory

end # module Scg
