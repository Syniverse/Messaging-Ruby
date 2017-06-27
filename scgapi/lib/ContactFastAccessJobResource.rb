module Scg

    module Api

        class ContactFastAccessJobResource < Scg::Api::BaseResource
            @@resource_path = 'contacts/fast_access_jobs'

            def initialize(requester)
                super(requester, @@resource_path)
            end

        end

    end # module Api

end # module Scg

