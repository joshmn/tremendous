module Tremendous
  module Operations
    module Destroy
      def destroy(id)
        resp = delete("#{resource_path}/#{id}")
        Utils.build_object(resp, self)
      end
    end
  end
end