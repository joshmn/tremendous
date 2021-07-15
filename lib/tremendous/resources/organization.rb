# frozen_string_literal: true

module Tremendous
  class Organization < APIResource
    extend Operations::Create
    extend Operations::List
    extend Operations::Retrieve

    member_method :create_access_token, :post
  end
end
