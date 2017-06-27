module Scg

    module Api

        class ContactResource < Scg::Api::BaseResource
            @@resource_path = 'contacts'

            def initialize(requester)
                super(requester, @@resource_path)
            end

            def access_tokens(contact_id)
                return Scg::Api::ContactAccessTokenResource.new(@requester, contact_id)
            end

            def application_tokens(contact_id)
                return Scg::Api::ContactApplicationTokenResource.new(@requester, contact_id)
            end
        end

    end # module Api

end # module Scg

