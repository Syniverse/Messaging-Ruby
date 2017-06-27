module Scg

    module Api

        class Client

            def initialize(authenticator, options)
                @requester = Scg::Api::Requester.new(options['base_url'],
                                                     Scg::Api::JsonPayloadReader.new(),
                                                     Scg::Api::JsonPayloadWriter.new(),
                                                     options['http'])
                @requester.add_interceptor(lambda { |request| authenticator.process_request(request) })
            end

            def access_tokens
                unless defined? @access_tokens
                    @access_tokens = Scg::Api::AccessTokenResource.new(@requester)
                end
                return @access_tokens
            end

            def attachments
                unless defined? @attachments
                    @attachments = Scg::Api::AttachmentResource.new(@requester)
                end
                return @attachments
            end

            def channels
                unless defined? @channels
                    @channels = Scg::Api::ChannelResource.new(@requester)
                end
                return @channels
            end

            def contact_address_history
                unless defined? @contact_address_history
                    @contact_address_history = Scg::Api::ContactAddressHistoryResource.new(@requester)
                end
                return @contact_address_history
            end

            def contact_address_statuses
                unless defined? @contact_address_statuses
                    @contact_address_statuses = Scg::Api::ContactAddressStatusResource.new(@requester)
                end
                return @contact_address_statuses
            end

            def contact_export
                unless defined? @contact_export
                    @contact_export = Scg::Api::ContactExportResource.new(@requester)
                end
                return @contact_export
            end

            def contact_import
                unless defined? @contact_import
                    @contact_import = Scg::Api::ContactImportResource.new(@requester)
                end
                return @contact_import
            end

            def contact_fast_access
                unless defined? @contact_fast_access
                    @contact_fast_access = Scg::Api::ContactFastAccessResource.new(@requester)
                end
                return @contact_fast_access
            end

            def contact_groups
                unless defined? @contact_groups
                    @contact_groups = Scg::Api::ContactGroupResource.new(@requester)
                end
                return @contact_groups
            end

            def contacts
                unless defined? @contacts
                    @contacts = Scg::Api::ContactResource.new(@requester)
                end
                return @contacts
            end

            def keywords
                unless defined? @keywords
                    @keywords = Scg::Api::KeywordResource.new(@requester)
                end
                return @keywords
            end

            def message_requests
                unless defined? @message_requests
                    @message_requests = Scg::Api::MessageRequestResource.new(@requester)
                end
                return @message_requests
            end

            def messages
                unless defined? @messages
                    @messages = Scg::Api::MessageResource.new(@requester)
                end
                return @messages
            end

            def message_templates
                unless defined? @message_templates
                    @message_templates = Scg::Api::MessageTemplateResource.new(@requester)
                end
                return @message_templates
            end

            def sender_id_classes
                unless defined? @sender_id_classes
                    @sender_id_classes = Scg::Api::SenderIdClassResource.new(@requester)
                end
                return @sender_id_classes
            end

            def sender_id_types
                unless defined? @sender_id_types
                    @sender_id_types = Scg::Api::SenderIdTypeResource.new(@requester)
                end
                return @sender_id_types
            end

            def sender_ids
                unless defined? @sender_ids
                    @sender_ids = Scg::Api::SenderIdResource.new(@requester)
                end
                return @sender_ids
            end

            def statistics
                unless defined? @statistics
                    @statistics = Scg::Api::StatisticsResource.new(@requester)
                end
                return @statistics
            end

        end # class Client

    end # module Api

end # module Scg
