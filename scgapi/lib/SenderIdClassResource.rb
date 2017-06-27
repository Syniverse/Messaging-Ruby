module Scg

    module Api

        class SenderIdClassResource < Scg::Api::BaseResource
            @@resource_path = 'messaging/sender_id_classes'

            def initialize(requester)
                super(requester, @@resource_path)
            end

        end

    end # module Api

end # module Scg

