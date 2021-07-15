# frozen_string_literal: true

module Tremendous
  class Organization < APIResource
    extend Operations::Create
    extend Operations::List
    extend Operations::Retrieve

    member_method :create_access_token, :post, endpoint: 'access_token' do |resp|
      Utils.build_object(OpenStruct.new(parsed_response: { 'organization' => resp.parsed_response }), self)
    end
  end
end
