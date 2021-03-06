module Naas
  module Requests
    class AccountSmtpSettings
      # Retrieve the list of SMTP settings
      #
      # @param params [Hash]
      #
      # @return [Naas::Response]
      def self.list(params={})
        rel   = Naas::Client.rel_for('rels/smtp-settings')
        route = Naas::Client.routes.find_by_rel(rel)
        url   = route.url_for(params)

        request = Naas::Client.connection.get do |req|
          req.url(url)
          req.headers['Accept'] = 'application/vnd.naas.json; version=1'
        end

        Naas::Response.new(request)
      end

      # Retrieve the instance of an SMTP setting
      #
      # @param id [Integer]
      # @param params [Hash]
      #
      # @return [Naas::Response]
      def self.retrieve(id, params={})
        rel   = Naas::Client.rel_for('rels/smtp-setting')
        route = Naas::Client.routes.find_by_rel(rel)
        url   = route.url_for(params.merge!(id: id))

        request = Naas::Client.connection.get do |req|
          req.url(url)
          req.headers['Accept'] = 'application/vnd.naas.json; version=1'
        end

        Naas::Response.new(request)
      end

      # Retrieve the instance of an SMTP Setting
      #
      # @param id [Integer]
      # @param params [Hash]
      #
      # @raises [Naas::Errors::RecordNotFoundError]
      #
      # @return [Naas::Response]
      def self.retrieve!(id, params={})
        rel   = Naas::Client.rel_for('rels/smtp-setting')
        route = Naas::Client.routes.find_by_rel(rel)
        url   = route.url_for(params.merge!(id: id))

        request = Naas::Client.connection.get do |req|
          req.url(url)
          req.headers['Accept'] = 'application/vnd.naas.json; version=1'
        end

        response = Naas::Response.new(request)

        response.on(:failure) do |resp|
          raise Naas::Errors::RecordNotFoundError.new(resp.body)
        end

        response
      end

      # Created a new record
      #
      # @param params [Hash]
      #
      # @return [Naas::Response]
      def self.create(params={})
        rel   = Naas::Client.rel_for('rels/smtp-settings')
        route = Naas::Client.routes.find_by_rel(rel)
        url   = route.url_for

        request_body = {
          :smtp_settings => params
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
