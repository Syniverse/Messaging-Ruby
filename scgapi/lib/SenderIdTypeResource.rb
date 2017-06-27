module Scg

    module Api

        class SenderIdTypeResource < Scg::Api::BaseResource
            @@resource_path = 'messaging/sender_id_types'

            def initialize(requester)
                super(requester, @@resource_path)
            end

        end

    end # module Api

end # module Scg

