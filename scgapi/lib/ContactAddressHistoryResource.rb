module Scg

    module Api

        class ContactAddressHistoryResource < Scg::Api::BaseResource
            @@resource_path = 'consent/contact_address_history'

            def initialize(requester)
                super(requester, @@resource_path)
            end

        end

    end # module Api

end # module Scg

