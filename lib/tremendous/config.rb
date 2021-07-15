# frozen_string_literal: true

module Tremendous
  class Config
    attr_accessor :api_key, :endpoint

    def initialize
      @endpoint = 'https://testflight.tremendous.com'
    end
  end
end
