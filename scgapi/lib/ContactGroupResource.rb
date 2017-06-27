module Scg

    module Api

        class ContactGroupResource < Scg::Api::BaseResource
            @@resource_path = 'contact_groups'

            def initialize(requester)
                super(requester, @@resource_path)
            end

            def list_contacts(id, params={})
                return @requester.request(:method => :get, :path => "#{get_resource_instance_path(id)}/contacts", :params => params)
            end

            def add_contacts(id, contacts)
                payload = {'contacts' => contacts}
                return @requester.request(:method => :post, :path => "#{get_resource_instance_path(id)}/contacts", :payload => payload)
            end

            def del_contact(id, contactId)
                return @requester.request(:method => :delete, :path => "#{get_resource_instance_path(id)}/contacts/#{contactId}")
            end

        end

    end # module Api

end # module Scg

