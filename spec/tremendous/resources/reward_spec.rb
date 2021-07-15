# frozen_string_literal: true

require 'spec_helper'

describe Tremendous::Reward do
  context '.list' do
    it_behaves_like '.list'
  end

  context '.retrieve' do
    it_behaves_like '.retrieve'
  end

  context '.approve' do
    before do
      stub_resource(described_class, :approve, url: "#{described_class.resource_path}/1/approve", method: :post)
    end

    subject { described_class.approve(1) }

    it 'returns a reward instance' do
      expect(subject).to be_an_instance_of described_class
    end
  end
end
