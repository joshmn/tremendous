require "bundler/setup"
require "tremendous"
require 'webmock'
require 'webmock/rspec'
require 'pry'

Tremendous.configure do |config|
  config.api_key = 'example'
  config.endpoint = 'https://testflight.tremendous.com'
end

module Recorder
  class Writer
    def initialize(spec)
      @spec = spec
    end

    def call(req, resp)
      request = {
                  uri: req.uri.to_s,
                  method: req.method.to_s.upcase,
                  headers: req.headers,
                  body: req.body
                }.to_json
      real_path = req.uri.path.split("api/v2/")[1].split("/")

      klass = real_path[0]
      if real_path.size == 3
        action = real_path.last
      elsif real_path.size == 1
        if req.method == :post
          action = :create
        elsif req.method == :get
          action = :list
        end
      elsif real_path.size == 2
        if req.method == :get
          action = :retrieve
        elsif req.method == :delete
          action = :delete
        end
      end

      begin
        FileUtils.mkdir(__dir__ + "/fixtures/#{klass}")
      rescue Errno::EEXIST => _e
      end
      File.write(File.join(__dir__ + "/fixtures/#{klass}/#{action}.json"), resp.body)
    end
  end
end

module StubResources
  def stub_resource(resource, action, **options)
    if options[:url]
      url = options[:url]
    else
      url = url_builder(resource, action: action)
    end

    verb = options[:method] || verb_for(resource, action)
    if options[:fixture] != false
      fixture_path = File.join(__dir__ + "/fixtures/#{resource.resource_key.tableize}/#{action}.json")
      body = File.read(fixture_path)
      stub_request(verb, "#{Tremendous.config.endpoint}#{url}").to_return(status: 200, body: body)
    else
      stub_request(verb, "#{Tremendous.config.endpoint}#{url}").to_return(status: 200)
    end
  end

  private

  def url_builder(resource, action)
    if action == :list || :create
      return resource.resource_path
    end
  end

  def verb_for(resource, action)
    if action == :list || :retrieve
      return :get
    end

    if action == :create
      return :post
    end

    if action == :destroy
      return :delete
    end

    resource.member_endpoints[action] || raise(ArgumentError, "unknown type for #{action}")
  end
end

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include StubResources

  if ENV['CREATE_FIXTURES']
    config.around(:each) do |example|
      WebMock::CallbackRegistry.add_callback({}, Recorder::Writer.new(example))
      example.run
      WebMock::CallbackRegistry.reset
    end
    WebMock.allow_net_connect!
  else
    WebMock.disable_net_connect!
  end
end

shared_examples_for "shared response" do
  xit 'has an auth in the header' do
    request = Array.new(subject).first.response
  end
end

shared_examples_for ".list" do
  before do
    stub_resource(described_class, :list)
  end

  subject { described_class.list }

  it 'returns an array' do
    expect(subject).to be_an(Array)
  end

  it 'is an array of described class' do
    expect(subject.first).to be_an_instance_of described_class
  end

  it_behaves_like "shared response"
end

shared_examples_for ".retrieve" do
  before do
    stub_resource(described_class, :retrieve, url: "#{described_class.resource_path}/1")
  end

  subject { described_class.retrieve(1) }

  it 'returns an instance' do
    expect(subject).to be_an_instance_of(described_class)
  end

  it 'hits resource path' do
    expect(subject.response.uri.path).to eq("#{described_class.resource_path}/1")
  end

  it_behaves_like "shared response"
end

shared_examples_for ".create" do
  before do
    stub_resource(described_class, :create, url: "#{described_class.resource_path}", method: :post)
  end

  subject { described_class.create({}) }

  it 'returns an instance' do
    expect(subject).to be_an_instance_of(described_class)
  end

  it 'hits the resource path' do
    expect(subject.response.uri.path).to eq("#{described_class.resource_path}")
  end

  it_behaves_like "shared response"
end

shared_examples_for ".delete" do
  before do
    stub_resource(described_class, :delete, url: "#{described_class.resource_path}/1", method: :delete)
  end

  subject { described_class.destroy(1) }

  it 'returns an instance' do
    expect(subject).to be_an_instance_of(described_class)
  end

  it 'hits the resource path' do
    expect(subject.response.uri.path).to eq("#{described_class.resource_path}/1")
  end

  it_behaves_like "shared response"
end

