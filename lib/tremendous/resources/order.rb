module Tremendous
  class Order < APIResource
    extend Operations::Retrieve
    extend Operations::List
    extend Operations::Create
  end
end