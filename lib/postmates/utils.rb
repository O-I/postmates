require 'uri'
require 'date'

module Postmates
  module Utils
    def urlify(href)
      URI(href) if href
    end

    def timeify(timestamp)
      DateTime.iso8601 timestamp if timestamp
    end
  end
end