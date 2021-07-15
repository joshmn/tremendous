# frozen_string_literal: true

require 'spec_helper'

describe Tremendous::Organization do
  context '.create' do
    it_behaves_like '.create'
  end

  context '.list' do
    it_behaves_like '.list'
  end

  context '.retrieve' do
    it_behaves_like '.retrieve'
  end

  context '.create_access_token' do
    it 'returns an access_token' do
      response = stub_resource(described_class, :create_access_token, url: '/api/v2/organizations/1/access_token',
                                                                      method: :post)
      req = described_class.create_access_token(1)
      expect(req.access_token).to eq(response[:body]['access_token'])
    end
  end
end
