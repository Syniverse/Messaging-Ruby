module Scg

    module Api

        class AttachmentResource < Scg::Api::BaseResource
            @@resource_path = 'messaging/attachments'

            def initialize(requester)
                super(requester, @@resource_path)
            end

            def createAccessToken(id)
                return @requester.request(:method => :post, :path => "#{get_resource_instance_path(id)}/access_tokens")
            end

            def transferContent(id, payload, type = 'application/octet-stream')
                uri = URI(requester.base_url)
                port = uri.port ? ":#{uri.port}" : ''
                url = "#{uri.scheme}://#{uri.host}#{port}/scg-attachment/api/v1/messaging/attachments/#{id}/content"
                return @requester.request(:method => :post,
                                          :url => url,
                                          :type => type,
                                          :payload => payload)
            end

            def upload(id, path)
                token = createAccessToken(id)['id']
                transferContent(token, File.read(path))
            end

        end

    end # module Api

end # module Scg

