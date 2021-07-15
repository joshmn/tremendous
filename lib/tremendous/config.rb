module Tremendous
  class Config
    attr_accessor :api_key
    attr_accessor :endpoint

    def initialize
      @endpoint = "https://testflight.tremendous.com"
    end
  end
end