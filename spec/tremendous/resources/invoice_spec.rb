require 'spec_helper'

describe Tremendous::Invoice do
  context '.list' do
    it_behaves_like '.list'
  end

  context '.retrieve' do
    it_behaves_like '.retrieve'
  end

  context '.create' do
    it_behaves_like '.create'
  end

  context '.delete' do
    it_behaves_like '.delete'
  end

  context '.pdf' do
    before do
      stub_resource(described_class, :pdf, url: "#{described_class.resource_path}/1/pdf", method: :get, fixture: false)
    end

    subject { described_class.pdf(1) }

    it 'returns a 200' do
      expect(subject).to be_an_instance_of(described_class)
    end

    it 'has a file method' do
      expect(subject.file).to be_a(HTTP::Response::Body)
    end
  end
end
