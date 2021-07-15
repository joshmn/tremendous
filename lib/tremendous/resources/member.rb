# frozen_string_literal: true

module Tremendous
  class Member < APIResource
    extend Operations::Create
    extend Operations::List
    extend Operations::Retrieve
  end
end
