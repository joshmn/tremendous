# frozen_string_literal: true

module Tremendous
  class Reward < APIResource
    extend Operations::Retrieve
    extend Operations::List

    member_method :approve, :post
  end
end
