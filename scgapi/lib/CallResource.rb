module Scg

  module Api

    class CallResource < Scg::Api::BaseResource
      @@resource_path = 'calling/calls'

      def initialize(requester)
        super(requester, @@resource_path)
      end

    end

  end # module Api

end # module Scg

