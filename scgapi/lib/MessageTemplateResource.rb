module Scg

    module Api

        class MessageTemplateResource < Scg::Api::BaseResource
            @@resource_path = 'messaging/message_templates'

            def initialize(requester)
                super(requester, @@resource_path)
            end

        end

    end # module Api

end # module Scg

