module Scg

    module Api

        class AccessTokenResource < Scg::Api::BaseResource
            @@resource_path = 'access_tokens'

            def initialize(requester)
                super(requester, @@resource_path)
            end

        end

    end # module Api

end # module Scg

