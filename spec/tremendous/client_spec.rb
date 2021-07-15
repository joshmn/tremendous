# frozen_string_literal: true

require 'spec_helper'

describe Tremendous::Client do
  context '400' do
    it 'returns a bad request' do
      stub_resource(Tremendous::Reward, :retrieve, url: "#{Tremendous::Reward.resource_path}/2", method: :get,
                                                   return: { status: 400, body: { "errors": { "message": 'Top level error message', "payload": {} } }.to_json })
      expect(Tremendous::Reward.retrieve(2)).to be_an_instance_of(Tremendous::BadRequest)
    end
  end

  context '401' do
    it 'returns an unauthorized' do
      stub_resource(Tremendous::Reward, :retrieve, url: "#{Tremendous::Reward.resource_path}/2", method: :get,
                                                   return: { status: 401, body: { "errors": { "message": 'Top level error message', "payload": {} } }.to_json })
      expect(Tremendous::Reward.retrieve(2)).to be_an_instance_of(Tremendous::Unauthorized)
    end
  end

  context '402' do
    it 'returns an payment failure' do
      stub_resource(Tremendous::Reward, :retrieve, url: "#{Tremendous::Reward.resource_path}/2", method: :get,
                                                   return: { status: 402, body: { "errors": { "message": 'Top level error message', "payload": {} } }.to_json })
      expect(Tremendous::Reward.retrieve(2)).to be_an_instance_of(Tremendous::PaymentFailure)
    end
  end

  context '404' do
    it 'returns a not found' do
      stub_resource(Tremendous::Reward, :retrieve, url: "#{Tremendous::Reward.resource_path}/2", method: :get,
                                                   return: { status: 404, body: { "errors": { "message": 'Top level error message', "payload": {} } }.to_json })
      expect(Tremendous::Reward.retrieve(2)).to be_an_instance_of(Tremendous::NotFound)
    end
  end

  context '429' do
    it 'returns a rate limited' do
      stub_resource(Tremendous::Reward, :retrieve, url: "#{Tremendous::Reward.resource_path}/2", method: :get,
                                                   return: { status: 429, body: { "errors": { "message": 'Top level error message', "payload": {} } }.to_json })
      expect(Tremendous::Reward.retrieve(2)).to be_an_instance_of(Tremendous::RateLimited)
    end
  end
end
