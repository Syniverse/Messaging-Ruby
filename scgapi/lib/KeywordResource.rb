module Scg

    module Api

        class KeywordResource < Scg::Api::BaseResource
            @@resource_path = 'messaging/keywords'

            def initialize(requester)
                super(requester, @@resource_path)
            end

        end

    end # module Api

end # module Scg

