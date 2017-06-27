module Scg

    module Api

        class MessageRequestResource < Scg::Api::BaseResource
            @@resource_path = 'messaging/message_requests'

            def initialize(requester)
                super(requester, @@resource_path)
            end

            def list_messages(id, params={})
                return @requester.request(:method => :get, :path => "#{get_resource_instance_path(id)}/messages", :params => params)
            end

        end

    end # module Api

end # module Scg

