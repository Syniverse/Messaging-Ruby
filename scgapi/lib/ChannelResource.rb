module Scg

    module Api

        class ChannelResource < Scg::Api::BaseResource
            @@resource_path = 'messaging/channels'

            def initialize(requester)
                super(requester, @@resource_path)
            end

            def list_sender_ids(id, params={})
                return @requester.request(:method => :get, :path => "#{get_resource_instance_path(id)}/sender_ids", :params => params)
            end

            def add_sender_ids(id, senderIds)
                return @requester.request(:method => :post, :path => "#{get_resource_instance_path(id)}/sender_ids", :payload => senderIds)
            end

            def del_sender_ids(id, senderId)
                return @requester.request(:method => :delete, :path => "#{get_resource_instance_path(id)}/sender_ids/#{senderId}")
            end

        end

    end # module Api

end # module Scg

