module Naas
  module Models
    class Campaigns
      include Enumerable

      # Return an instance of the campaigns
      #
      # @param collection [Array]
      #
      # @return [Naas::Models::Campaigns]
      def initialize(collection)
        @collection = Array(collection)
      end

      # Helper method to retrieve from the
      # request
      #
      # @return [Naas::Models::Campaigns]
      def self.list(params={})
        request = Naas::Requests::Campaigns.list(params)

        klass_attributes = []

        request.on(:success) do |resp|
          response_body = resp.body
          response_data = response_body.fetch('data', [])

          klass_attributes = response_data
        end

        request.on(:failure) do |resp|
          Naas::Client.configuration.logger.info { ("Failure retrieving the campaigns: %s" % [resp.status]) }
        end

        self.new(klass_attributes)
      end

      # Helper method to retrieve from the request
      #
      # @return [Naas::Models::Campaign]
      def self.retrieve(id, params={})
        request = Naas::Requests::Campaigns.retrieve(id, params)

        klass_attributes = {}

        request.on(:success) do |resp|
          response_body = resp.body
          response_data = response_body.fetch('data', {})

          klass_attributes = response_data
        end

        request.on(:failure) do |resp|
          Naas::Client.configuration.logger.info { ("Failure retrieving the campaign: %s" % [resp.status]) }
        end

        Naas::Models::Campaign.new(klass_attributes)
      end

      def each(&block)
        internal_collection.each(&block)
      end

      private
      def internal_collection
        @collection.map { |record| Naas::Models::Campaign.new(record) }
      end
    end
  end
end