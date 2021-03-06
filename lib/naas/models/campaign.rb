module Naas
  module Models
    class Campaign
      include Comparable

      # Returns an instance of the Campaign
      #
      # has_many :campaign_email_templates
      #
      # @param attributes [Hash]
      #
      # @return [Naas::Models::Campaign]
      def initialize(attributes={})
        @attributes = attributes
      end

      # Returns the ID
      #
      # @return [Integer]
      def id
        @attributes['id']
      end

      # Returns the account addon ID
      #
      # @return [Integer]
      def account_addon_id
        @attributes['account_addon_id']
      end

      # Returns the associated project id
      #
      # @return [Integer]
      def project_id
        @attributes['project_id']
      end

      # Returns the name
      #
      # @return [String]
      def name
        @attributes['name']
      end

      # Returns the description
      #
      # @return [String]
      def description
        @attributes['description']
      end

      # Returns the account addon attributes
      #
      # @return [Boolean]
      def account_addon_attributes
        @attributes.fetch('account_addon', {})
      end

      # Returns true if there are any account addon
      # attributes
      #
      # @return [Boolean]
      def account_addon_attributes?
        !self.account_addon_attributes.empty?
      end

      # Returns the associated account addon
      #
      # @return [Naas::Models::AccountAddon]
      def account_addon
        @account_addon ||= if self.account_addon_attributes?
                             Naas::Models::AccountAddon.new(self.account_addon_attributes)
                           else
                             Naas::Models::AccountAddons.retrieve(self.account_addon_id)
                           end
      end

      # Returns true if there is an account addon
      #
      # @return [Boolean]
      def account_addon?
        !self.account_addon.nil?
      end

      # Return the associated campaign email templates
      # attributes
      #
      # @return [Array]
      def campaign_email_templates_attributes
        @attributes.fetch('campaign_email_templates', [])
      end

      # Returns true if there are campaign email template
      # attributes
      #
      # @return [Boolean]
      def campaign_email_templates_attributes?
        self.campaign_email_templates_attributes.any?
      end

      # Returns the campaign email templates
      #
      # @return [Naas::Models::CampaignEmailTemplates]
      def campaign_email_templates
        @campaign_email_templates ||= if self.campaign_email_templates_attributes?
                                        Naas::Models::CampaignEmailTemplates.new(self.campaign_email_templates)
                                      else
                                        Naas::Models::CampaignEmailTemplates.list_by_project_id_and_campaign_id(self.project_id, self.id)
                                      end
      end

      def campaign_email_templates?
        self.campaign_email_templates.any?
      end

      # Returns the created at timestamp
      #
      # @return [DateTime,NilClass]
      def created_at
        begin
          DateTime.parse(@attributes['created_at'])
        rescue
          nil
        end
      end

      # Returns the updated at timestamp
      #
      # @return [DateTime,NilClass]
      def updated_at
        begin
          DateTime.parse(@attributes['updated_at'])
        rescue
          nil
        end
      end

      # Returns the links attributes
      #
      # @return [Array]
      def links_attributes
        @attributes.fetch('links', [])
      end

      # Returns the Links
      #
      # @return [Naas::Models::Links]
      def links
        @links ||= Naas::Models::Links.new(self.links_attributes)
      end

      # Returns true if there are any links
      #
      # @return [Boolean]
      def links?
        self.links.any?
      end
    end
  end
end
