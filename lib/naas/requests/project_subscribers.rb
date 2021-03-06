module Naas
  module Requests
    class ProjectSubscribers

      # Retrieve the list of subscribers by project
      #
      # @param project_id [String]
      # @param params [Hash]
      #
      # @return [Naas::Response]
      def self.list_by_project_id(project_id, params={})
        rel   = Naas::Client.rel_for('rels/project-subscribers')
        route = Naas::Client.routes.find_by_rel(rel)
        url   = route.url_for(params.merge!(project_id: project_id))

        request = Naas::Client.connection.get do |req|
          req.url(url)
          req.headers['Accept'] = 'application/vnd.naas.json; version=1'
        end

        Naas::Response.new(request)
      end

      # Retrieve the instance of a project subscriber by project
      #
      # @param project_id [String]
      # @param id [String]
      # @param params [Hash]
      #
      # @return [Naas::Response]
      def self.retrieve_by_project_id(project_id, id, params={})
        rel   = Naas::Client.rel_for('rels/project-subscriber')
        route = Naas::Client.routes.find_by_rel(rel)
        url   = route.url_for(params.merge!(project_id: project_id, id: id))

        request = Naas::Client.connection.get do |req|
          req.url(url)
          req.headers['Accept'] = 'application/vnd.naas.json; version=1'
        end

        Naas::Response.new(request)
      end

      # Create a new record
      #
      # @param project_id [String]
      # @param params [Hash]
      #
      # @return [Naas::Response]
      def self.create_by_project_id(project_id, params={})
        rel   = Naas::Client.rel_for('rels/project-subscribers')
        route = Naas::Client.routes.find_by_rel(rel)
        url   = route.url_for(project_id: project_id)

        request_body = {
          :project_subscriber => params
        }

        request = Naas::Client.connection.post do |req|
          req.url(url)
          req.headers['Accept'] = 'application/vnd.naas.json; version=1'
          req.body = MultiJson.dump(request_body)
        end

        Naas::Response.new(request)
      end
    end
  end
end
