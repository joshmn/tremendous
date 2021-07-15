# frozen_string_literal: true

module Tremendous
  class APIResource
    def self.resource_path
      "/api/v2/#{collection_key}"
    end

    def self.resource_key
      name.demodulize.underscore
    end

    def self.collection_key
      name.demodulize.underscore.pluralize
    end

    def self.get(url, **args)
      Client.execute_resource_request(:get, url, **args)
    end

    def self.post(url, **args)
      Client.execute_resource_request(:post, url, **args)
    end

    def self.delete(url, **args)
      Client.execute_resource_request(:delete, url, **args)
    end

    def self.member_endpoints
      @member_endpoints ||= {}
    end

    def self.member_method(name, verb, endpoint: nil, &block)
      member_endpoints[name] = verb
      define_singleton_method(name) do |id, **args|
        url = [resource_path, id, endpoint || name].join('/')
        resp = send(verb, url, **args)
        if block
          block.call(resp)
        else
          Utils.build_object(resp, self)
        end
      end
    end

    def self.member_action(name, verb, endpoint = nil, &block)
      member_endpoints[name] = verb
      define_method(name) do |**args|
        url = [self.class.resource_path, id, endpoint || name].join('/')
        resp = self.class.send(verb, url, **args)
        if block
          block.call(resp)
        else
          Utils.build_object(resp, self.class)
        end
      end
    end

    def initialize(parsed_response, options = {})
      self.class.attr_reader(*parsed_response.keys)
      self.class.attr_reader :response
      @response = options[:response]
      parsed_response.each do |k, v|
        case v
        when Hash
          v.each do |attr, value|
            instance_variable_set(:"@#{attr}", value)
          end
        when Array
          objs = v.map do |thing|
            if thing.is_a?(Hash)
              struct = Class.new(Struct.new(*thing.keys.map(&:to_sym)))
              struct.new(*thing.values)
            else
              thing
            end
          end
          instance_variable_set(:"@#{k}", objs)
        else
          instance_variable_set(:"@#{k}", v)
        end
      end
    end

    def [](key)
      @response[key]
    end
  end
end
