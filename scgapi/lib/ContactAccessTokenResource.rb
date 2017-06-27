module Scg

    module Api

        class ContactAccessTokenResource < Scg::Api::BaseResource

            def initialize(requester, contact_id)
                super(requester, "contacts/#{contact_id}/access_tokens")
            end

        end

    end # module Api

end # module Scg

