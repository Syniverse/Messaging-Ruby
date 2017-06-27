module Scg

    module Api

        class ContactImportResource < Scg::Api::BaseResource
            @@resource_path = 'contactimport'

            def initialize(requester)
                super(requester, @@resource_path)
            end

        end

    end # module Api

end # module Scg

