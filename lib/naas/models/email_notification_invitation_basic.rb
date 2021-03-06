module Naas
  module Models
    class EmailNotificationInvitationBasic
      # Helper method to create from the request
      #
      # @param email_address [String]
      # @param project_id [String]
      # @param campaign_id [String]
      # @param campaign_email_template_id [String]
      # @param from_name [String]
      # @param sender_email_address [String]
      # @param content [Hash]
      # @param options [Hash]
      #
      # @return [Naas::Models::EmailNotification]
      def self.create(email_address:, project_id:, campaign_id:, campaign_email_template_id:, from_name:, sender_email_address:, content: {}, options: {})
        request = Naas::Requests::EmailNotificationInvitationBasics.create_from_attributes(email_address, project_id, campaign_id, campaign_email_template_id, from_name, sender_email_address, content, options)

        request.on(:success) do |resp|
          return Naas::Models::EmailNotification.new(resp.data_attributes)
        end

        request.on(:failure) do |resp|
          error           = Naas::Models::Error.new(resp.data_attributes)
          failure_message = "Failure creating the record: %s" % [error.full_messages.inspect]

          Naas::Client.configuration.logger.error { failure_message }

          raise Naas::Errors::InvalidRequestError.new(failure_message)
        end
      end
    end
  end
end
