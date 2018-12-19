module Naas
  module Models
    class Projects
      include Enumerable

      # Return an instance of the projects
      #
      # @param collection [Array]
      #
      # @return [Naas::Models::Projects]
      def initialize(collection)
        @collection = Array(collection)
      end

      # Helper method to retrieve from the
      # request
      #
      # @return [Naas::Models::Projects]
      def self.list(params={})
        request = Naas::Requests::Projects.list(params)

        klass_attributes = []

        request.on(:success) do |resp|
          response_body = resp.body
          response_data = response_body.fetch('data', [])

          klass_attributes = response_data
        end

        request.on(:failure) do |resp|
          Naas::Client.configuration.logger.info { ("Failure retrieving the projects: %s" % [resp.status]) }
        end

        self.new(klass_attributes)
      end

      # Helper method to retrieve from the request
      #
      # @return [Naas::Models::Project]
      def self.retrieve(id, params={})
        request = Naas::Requests::Projects.retrieve(id, params)

        klass_attributes = {}

        request.on(:success) do |resp|
          response_body = resp.body
          response_data = response_body.fetch('data', {})

          klass_attributes = response_data
        end

        request.on(:failure) do |resp|
          Naas::Client.configuration.logger.info { ("Failure retrieving the project: %s" % [resp.status]) }
        end

        Naas::Models::Project.new(klass_attributes)
      end

      # Create a new project
      #
      # @raises [Naas::InvalidRequestError]
      #
      # @return [Naas::Models::Project]
      def self.create(params={})
        request = Naas::Requests::Projects.create(params)

        request.on(:success) do |resp|
          response_body = resp.body
          response_data = response_body.fetch('data', {})

          klass_attributes = response_data

          return Naas::Models::Project.new(klass_attributes)
        end

        request.on(:failure) do |resp|
          response_body = resp.body
          response_data = response_body.fetch('data', {})

          error           = Naas::Models::Error.new(response_data)
          failure_message = "Failure creating the project: %s" % [error.full_messages.inspect]

          Naas::Client.configuration.logger.info { failure_message }

          raise Naas::Errors::InvalidRequestError.new(failure_message)
        end
      end

      def each(&block)
        internal_collection.each(&block)
      end

      private
      def internal_collection
        @collection.map { |record| Naas::Models::Project.new(record) }
      end
    end
  end
end
