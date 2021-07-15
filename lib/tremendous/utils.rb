module Tremendous
  class Utils
    class << self
      def build_object(response, object_name)
        if response.is_a?(Error)
          return response
        end

        if response.parsed_response[object_name.collection_key]
          response.parsed_response[object_name.collection_key].map { |obj| object_name.new(obj, response: response) }
        elsif response.parsed_response[object_name.resource_key]
          object_name.new(response.parsed_response[object_name.resource_key], response: response)
        else
          raise "Unknown response collection type for object_name #{object_name} with response #{response.inspect}"
        end
      end
    end
  end
end
