# frozen_string_literal: true

module Tremendous
  module Operations
    module List
      def list(query = {})
        resp = get(resource_path.to_s, params: query)
        Utils.build_object(resp, self)
      end
    end
  end
end
