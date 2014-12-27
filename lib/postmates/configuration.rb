require_relative 'version'

module Postmates
  module Configuration

    VALID_CONFIGURATION_KEYS = [:headers, :api_url, :api_key, :customer_id]

    attr_accessor *VALID_CONFIGURATION_KEYS

    DEFAULT_API_URL = 'https://api.postmates.com/v1/'
    DEFAULT_HEADERS = {
                        accept: 'application/json',
                        user_agent: "postmates gem #{Postmates::Version}"
                      }

    def configure
      yield self
    end

    def reset
      self.headers     = DEFAULT_HEADERS
      self.api_url     = DEFAULT_API_URL
      self.api_key     = nil
      self.customer_id = nil
      self
    end
  end
end