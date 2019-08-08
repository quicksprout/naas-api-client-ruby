module Naas
  module Models
    class ProjectSubscribers
      include Enumerable

      COLUMNS = ['ID', 'Project ID', 'Subscriber ID', 'Email Addresses', 'Code', 'Created At']

      # Return an instance of the project subscribers
      #
      # @param collection [Array]
      #
      # @return [Naas::Models::ProjectSubscribers]
      def initialize(collection)
        @collection = Array(collection)
      end

      # Helper to retrieve the headings collection
      #
      # @return [Array]
      def self.headings
        COLUMNS
      end

      # Returns the class level headings
      #
      # @return [Array]
      def headings
        self.class.headings
      end

      # Helper method to retrieve from the
      # request
      #
      # @param project_id [String]
      # @param params [Hash]
      #
      # @return [Naas::Models::ProjectSubscribers]
      def self.list_by_project_id(project_id, params={})
        request = Naas::Requests::ProjectSubscribers.list_by_project_id(project_id, params)

        klass_attributes = []

        request.on(:success) do |resp|
          klass_attributes = resp.data_attributes
        end

        request.on(:failure) do |resp|
          Naas::Client.configuration.logger.error { ("Failure retrieving the project subscribers: %s" % [resp.status]) }
        end

        self.new(klass_attributes)
      end

      # Helper method to retrieve from the request
      #
      # @param project_id [String]
      # @param id [String]
      # @param params [Hash]
      #
      # @return [Naas::Models::ProjectSubscriber]
      def self.retrieve_by_project_id(project_id, id, params={})
        request = Naas::Requests::ProjectSubscribers.retrieve_by_project_id(project_id, id, params)

        request.on(:success) do |resp|
          return Naas::Models::ProjectSubscriber.new(resp.data_attributes)
        end

        request.on(:failure) do |resp|
          Naas::Client.configuration.logger.error { ("Failure retrieving the project subscriber: %s" % [resp.status]) }

          return nil
        end
      end

      # Helper method to retrieve from the request
      #
      # @param project_id [String]
      # @param id [String]
      # @param params [Hash]
      #
      # @raises [Naas::Errors::RecordNotFoundError]
      #
      # @return [Naas::Models::ProjectSubscriber]
      def self.retrieve_by_project_id!(project_id, id, params={})
        request = Naas::Requests::ProjectSubscribers.retrieve_by_project_id(project_id, id, params)

        request.on(:success) do |resp|
          return Naas::Models::ProjectSubscriber.new(resp.data_attributes)
        end

        request.on(404) do
          raise Naas::Errors::RecordNotFoundError.new("Could not find record with id: %s" % [id])
        end
      end

      # Create a new project subscriber
      #
      # @param project_id [String]
      # @param params [Hash]
      #
      # @raises [Naas::InvalidRequestError]
      #
      # @return [Naas::Models::ProjectSubscriber]
      def self.create_by_project_id(project_id, params={})
        request = Naas::Requests::ProjectSubscribers.create_by_project_id(project_id, params)

        request.on(:success) do |resp|
          return Naas::Models::ProjectSubscriber.new(resp.data_attributes)
        end

        request.on(:failure) do |resp|
          error           = Naas::Models::Error.new(resp.data_attributes)
          failure_message = "Failure creating the record: %s" % [error.full_messages.inspect]

          Naas::Client.configuration.logger.error { failure_message }

          raise Naas::Errors::InvalidRequestError.new(failure_message)
        end
      end

      def each(&block)
        internal_collection.each(&block)
      end

      # Returns the collection serialized as an array
      #
      # @return [Array]
      def to_a
        self.map(&:to_a)
      end

      private
      def internal_collection
        @collection.map { |record| Naas::Models::ProjectSubscriber.new(record) }
      end
    end
  end
end
