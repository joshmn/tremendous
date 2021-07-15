# frozen_string_literal: true

require 'http'
require 'json'
require 'active_support/inflector'
require 'tremendous/utils'
require 'tremendous/version'
require 'tremendous/error'
require 'tremendous/config'
require 'tremendous/client'

module HTTP
  class Response
    def parsed_response
      JSON.parse(to_s)
    end
  end
end

require 'tremendous/resources'
module Tremendous
  def self.configure
    yield config
  end

  def self.config
    @config ||= Config.new
  end
end
