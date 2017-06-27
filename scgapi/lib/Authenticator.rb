
require 'json'

module Scg

  module Api

    class Authenticator
      attr_reader :token, :appid, :companyid, :transactionid, :quotaplan

      def initialize(token: nil, json_config: nil)
        @token = token

        if json_config
          data = JSON.parse(File.read(json_config))

          @token = data['token'] unless @token
          @appid = data['appid']
          @companyid = data['companyid']
          @transactionid = data['transactionid']
          @quotaplan = data['quotaplan']
        end
      end

      def process_request(request)
        request[:headers]['Authorization'] = "Bearer #{@token}" if @token
        request[:headers]['int-appId'] = @appid if @appid
        request[:headers]['int-companyId'] = @companyid if @companyid
        request[:headers]['int-txnId'] = @transactionid if @transactionid
        request[:headers]['int-quota-plan'] = @quotaplan if @quotaplan
      end

    end # class Authenticator

  end # module Api

end # module Scg

