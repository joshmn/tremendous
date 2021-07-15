# frozen_string_literal: true

module Tremendous
  module Operations
    module Create
      def create(body = {})
        resp = post(resource_path.to_s, json: body)
        Utils.build_object(resp, self)
      end
    end
  end
end
