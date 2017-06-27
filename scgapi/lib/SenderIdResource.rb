module Scg

    module Api

        class SenderIdResource < Scg::Api::BaseResource
            @@resource_path = 'messaging/sender_ids'

            def initialize(requester)
                super(requester, @@resource_path)
            end

            def purchase(senderId)
                return @requester.request(:method => :post, :path => "#{get_resource_path()}/purchase", :payload => senderId)
            end
        end

    end # module Api

end # module Scg

