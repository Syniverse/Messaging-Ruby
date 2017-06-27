module Scg

    module Api

        class ContactFastAccessResource < Scg::Api::BaseResource
            @@resource_path = 'contacts/fast_access'

            def initialize(requester)
                super(requester, @@resource_path)
            end

        end

    end # module Api

end # module Scg

