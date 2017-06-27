module Scg

    module Api

        class ContactAddressStatusResource < Scg::Api::BaseResource
            @@resource_path = 'consent/contact_address_statuses'

            def initialize(requester)
                super(requester, @@resource_path)
            end

        end

    end # module Api

end # module Scg

