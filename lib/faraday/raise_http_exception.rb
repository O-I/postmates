require 'json'
require 'faraday'
require_relative '../postmates/error'

module FaradayMiddleware
  class RaiseHTTPException < Faraday::Middleware
    def call(env)
      @app.call(env).on_complete do |response|
        response_hash = JSON.parse(response.body)
        msg = "#{response[:status]} #{response_hash['code']}: #{response_hash['message']}"

        case response[:status]
        when 400 ; raise Postmates::BadRequest,          msg
        when 401 ; raise Postmates::Unauthorized,        msg
        when 402 ; raise Postmates::CustomerSuspended,   msg
        when 403 ; raise Postmates::Forbidden,           msg
        when 404 ; raise Postmates::NotFound,            msg
        when 500 ; raise Postmates::InternalServerError, msg
        when 503 ; raise Postmates::ServiceUnavailable,  msg
        end

        if response[:status] >= 300
          raise Postmates::Error, msg
        end
      end
    end

    def initialize(app)
      super app
      @parser = nil
    end
  end
end
