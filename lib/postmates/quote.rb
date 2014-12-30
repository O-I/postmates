require_relative 'utils'

module Postmates
  class Quote
    include Postmates::Utils
    attr_reader :id, :created_at, :expires_at, :fee,
                :currency, :dropoff_eta, :duration

    def initialize(hash)
      @id          =         hash['id']
      @fee         =         hash['fee']
      @currency    =         hash['currency']
      @duration    =         hash['duration']
      @created_at  = timeify hash['created']
      @expires_at  = timeify hash['expires']
      @dropoff_eta = timeify hash['dropoff_eta']
    end
  end
end