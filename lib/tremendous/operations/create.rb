module Tremendous
  module Operations
    module Create
      def create(body = {})
        resp = post("#{resource_path}", json: body)
        Utils.build_object(resp, self)
      end
    end
  end
end