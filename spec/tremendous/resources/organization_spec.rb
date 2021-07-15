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
  context '.create_access_token'
end