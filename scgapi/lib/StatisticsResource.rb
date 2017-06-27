module Scg

    module Api

        class StatisticsResource < Scg::Api::BaseResource
            @@resource_path = 'statistics'

            def initialize(requester)
                super(requester, @@resource_path)
            end

        end

    end # module Api

end # module Scg

