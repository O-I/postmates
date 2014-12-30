require 'date'

module Postmates
  class Quote
    attr_reader :id, :created_at, :expires_at, :fee,
                :currency, :dropoff_eta, :duration

    def initialize(hash)
      @id          =                  hash['id']
      @fee         =                  hash['fee']
      @currency    =                  hash['currency']
      @duration    =                  hash['duration']
      @created_at  = DateTime.iso8601 hash['created']
      @expires_at  = DateTime.iso8601 hash['expires']
      @dropoff_eta = DateTime.iso8601 hash['dropoff_eta']
    end
  end
end