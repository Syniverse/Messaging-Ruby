module Scg

    module Api

        class JsonPayloadReader
            @@content_type = 'application/json'

            def read(payload)
                return JSON.parse(payload)
            end

            def get_content_type
                return @@content_type
            end

        end # class JsonPayloadReader

    end # module Api

end # module Scg
            