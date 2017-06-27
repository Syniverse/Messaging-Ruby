module Scg

    module Api

        class JsonPayloadWriter
            @@content_type = 'application/json'

            def write(payload)
                return payload.to_json
            end

            def get_content_type
                return @@content_type
            end

        end # class JsonPayloadWriter

    end # module Api

end # module Scg
            