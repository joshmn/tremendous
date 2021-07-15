# frozen_string_literal: true

module Tremendous
  class Client
    class << self
      ERROR_CODE_TO_ERROR_CLASS = {
        400 => BadRequest,
        401 => Unauthorized,
        402 => PaymentFailure,
        404 => NotFound,
        429 => RateLimited
      }.freeze

      def handle_error_response(resp)
        klass = ERROR_CODE_TO_ERROR_CLASS[resp.status] || Error
        return klass.new(resp) if resp.status.between?(400, 500)

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
