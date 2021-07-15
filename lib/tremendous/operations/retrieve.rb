module Tremendous
  module Operations
    module Retrieve
      def retrieve(id)
        resp = get("#{resource_path}/#{id}")
        Utils.build_object(resp, self)
      end
    end
  end
end