module Scg

  module Api

    class BridgeResource < Scg::Api::BaseResource
      @@resource_path = 'calling/bridges'

      def initialize(requester)
        super(requester, @@resource_path)
      end

    end

  end # module Api

end # module Scg

