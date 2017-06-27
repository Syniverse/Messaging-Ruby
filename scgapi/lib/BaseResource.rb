module Scg

    module Api

        class Iter
            def initialize(res, path , params)
                @res= res
                @path = path
                @params = params
                @offset = 0
            end

            def each
                begin
                    arg = {:offset => @offset}
                    arg.merge(@params) if @params
                    data = @res.list_raw({:offset => @offset})
                    @offset += data['list'].size
                    data['list'].each { |d| yield d}
                end while data['list'].size > 0
            end
        end

        class BaseResource
            def initialize(requester, resource_path)
                @requester = requester
                @resource_path = resource_path
            end

            def list(params={})
                Iter.new(self, get_resource_path(), params)
            end

            def list_raw(params={})
                return @requester.request(:method => :get, :path => get_resource_path(), :params => params)
            end

            def create(arg)
                return @requester.request(:method => :post, :path => get_resource_path(), :payload => arg)
            end

            def get(id)
                return @requester.request(:method => :get, :path => get_resource_instance_path(id))
            end

            def update(id, arg)
                return @requester.request(:method => :post, :path => get_resource_instance_path(id), :payload => arg)
            end

            def replace(id, arg)
                return @requester.request(:method => :put, :path => get_resource_instance_path(id), :payload => arg)
            end

            def delete(id)
                return @requester.request(:method => :delete, :path => get_resource_instance_path(id))
            end

            protected
            attr_reader :requester

            def get_resource_path()
                return @resource_path
            end

            def get_resource_instance_path(id)
                return "#{@resource_path}/" + "#{id}"
            end

        end # class BaseResource

    end # module Api

end # module Scg
