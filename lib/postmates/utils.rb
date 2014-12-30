require 'date'

module Postmates
  module Utils
    def timeify(timestamp)
      DateTime.iso8601 timestamp if timestamp
    end
  end
end