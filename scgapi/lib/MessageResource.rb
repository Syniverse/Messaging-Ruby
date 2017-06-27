module Scg

    module Api

        class MessageResource < Scg::Api::BaseResource
            @@resource_path = 'messaging/messages'

            def initialize(requester)
                super(requester, @@resource_path)
            end

            def list_attachments(id, params={})
                return @requester.request(:method => :get, :path => "#{get_resource_instance_path(id)}/attachments", :params => params)
            end

        end

    end # module Api

end # module Scg

