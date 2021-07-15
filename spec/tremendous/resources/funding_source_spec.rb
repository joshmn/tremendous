require 'spec_helper'

describe Tremendous::FundingSource do
  context '.list' do
    it_behaves_like '.list'
  end
  context '.retrieve' do
    it_behaves_like '.retrieve'
  end
end
