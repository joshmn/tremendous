# frozen_string_literal: true

module Tremendous
  class Error
    attr_reader :message, :payload, :code

    def initialize(resp)
      @code = resp.code
      if resp.mime_type.include?('json')
        @message = resp.parsed_response['errors']['message']
        @payload = resp.parsed_response['errors']['payload']
      else
        @message = 'Unknown error'
      end
    end
  end

  class BadRequest < Error; end

  class Unauthorized < Error; end

  class PaymentFailure < Error; end

  class NotFound < Error; end

  class RateLimited < Error; end
end
