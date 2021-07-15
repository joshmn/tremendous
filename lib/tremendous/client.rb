# frozen_string_literal: true

module Tremendous
  class Client
    class << self
      def handle_error_response(resp)
        return Error.new(resp) if resp.status.between?(400, 500)

        false
      end

      def execute_resource_request(verb, url, **options)
        resp = HTTP.auth("Bearer #{Tremendous.config.api_key}").send(verb, "#{Tremendous.config.endpoint}#{url}",
                                                                     **options)
        if error = handle_error_response(resp)
          return error
        end

        resp
      end
    end
  end
end
