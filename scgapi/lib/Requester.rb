module Scg

    module Api

        class Requester

            def initialize(api_base_url, payload_reader, payload_writer, options)
                @api_base_url = api_base_url
                @payload_reader = payload_reader
                @payload_writer = payload_writer

                if options.include?(:timeout)
                    @read_timeout = options[:timeout]
                    @open_timeout = options[:timeout]
                end

                if options.include?(:read_timeout)
                    @read_timeout = options[:read_timeout]
                end

                if options.include?(:open_timeout)
                    @open_timeout = options[:open_timeout]
                end

                @proxy = options.fetch(:proxy) if options.include?(:proxy)

                @interceptors = []
            end

            def base_url()
                @api_base_url
            end

            def request(args)
                path = args[:path]
                method = args[:method]
                params = args[:params] || {}
                payload = args[:payload]
                url = args[:url]

                url = "#{@api_base_url}/#{path}" unless url
                request = { :method => method, :url => url }
                request[:open_timeout] = @open_timeout if defined? @open_timeout
                request[:read_timeout] = @read_timeout if defined? @read_timeout
                request[:proxy] = @proxy if defined? @proxy

                content_type = args[:type] ? args[:type] : @payload_writer.get_content_type()

                request[:headers] = { 'Accept' => @payload_reader.get_content_type(),
                                      'Content-Type' => content_type,
                                      'params' => params }

                unless (payload.nil? || payload.empty?)
                    if (content_type == 'application/json')
                        request[:payload] = @payload_writer.write(payload)
                    else
                        request[:payload] = payload
                    end
                end

                @interceptors.each { |i| i.call(request) }

                response = RestClient::Request.execute(request)

                unless (response.body.nil? || response.body.empty?)
                    return @payload_reader.read(response.body)
                end
            end

            def add_interceptor(i)
                @interceptors.push(i)
            end

        end # class Requester

    end # module Api

end # module Scg
