require 'json'
require 'rspec'
require 'webmock/rspec'
require 'postmates'

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :expect }
end

WebMock.disable_net_connect!

def postmates_test_client
  Postmates.new.tap do |client|
    client.configure do |config|
      config.api_key = '1234'
      config.customer_id = 'abcd'
    end
  end
end

HTTP_REQUEST_METHODS = [:get, :post]

HTTP_REQUEST_METHODS.each do |verb|
  define_method("stub_#{verb}".to_sym) do |path, options = {}|
    file = options.delete(:returns)
    endpoint = 'https://1234:@api.postmates.com/v1/' + path
    headers  = Postmates::Configuration::DEFAULT_HEADERS
    stub_request(verb, endpoint)
      .with(headers: headers, body: options)
      .to_return(body: fixture(file))
  end
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def payload(params_file)
  JSON.parse(IO.read(fixture(params_file)))
end

def path_to(endpoint)
  "customers/#{customer_id}/#{endpoint}"
end