module Scg

    module Api

        class ContactExportResource < Scg::Api::BaseResource
            @@resource_path = 'contactexport'

            def initialize(requester)
                super(requester, @@resource_path)
            end

        end

    end # module Api

end # module Scg

