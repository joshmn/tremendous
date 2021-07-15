require 'http'
require 'json'
require 'active_support/inflector'
require 'tremendous/utils'
require 'tremendous/version'
require 'tremendous/error'
require 'tremendous/config'
require 'tremendous/client'

class HTTP::Response
  def parsed_response
    JSON.parse(to_s)
  end
end


require 'tremendous/resources'
module Tremendous
  def self.configure(&block)
    yield config
  end

  def self.config
    @config ||= Config.new
  end
end
