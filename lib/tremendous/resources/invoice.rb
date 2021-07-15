# frozen_string_literal: true

module Tremendous
  class Invoice < APIResource
    extend Operations::Create
    extend Operations::List
    extend Operations::Retrieve
    extend Operations::Destroy

    member_method :pdf, :get do |resp|
      Utils.build_object(OpenStruct.new(parsed_response: { 'invoice' => { 'file' => resp.body } }), self)
    end
  end
end
