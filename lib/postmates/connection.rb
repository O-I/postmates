require 'faraday_middleware'
require_relative '../faraday/raise_http_exception'

module Postmates
  module Connection

    private

    def connection
      options = {
        headers: headers,
        ssl: { verify: false },
        url: api_url
      }

      Faraday.new(options) do |connection|
        connection.use Faraday::Request::UrlEncoded
        connection.use Faraday::Request::BasicAuthentication, api_key, ''
        connection.use Faraday::Response::ParseJson
        connection.use FaradayMiddleware::RaiseHTTPException
        connection.adapter(Faraday.default_adapter)
      end
    end
  end
end