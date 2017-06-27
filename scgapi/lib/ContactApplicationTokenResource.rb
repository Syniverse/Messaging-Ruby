module Scg

    module Api

        class ContactApplicationTokenResource < Scg::Api::BaseResource

            def initialize(requester, contact_id)
                super(requester, "contacts/#{contact_id}/application_tokens")
            end

        end

    end # module Api

end # module Scg
