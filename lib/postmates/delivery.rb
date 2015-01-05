require_relative 'utils'

module Postmates
  class Delivery
    include Postmates::Utils
    attr_reader :id, :created_at, :updated_at, :status, :complete,
                :pickup_eta, :dropoff_eta, :dropoff_deadline,
                :quote_id, :fee, :currency, :manifest, :pickup,
                :dropoff, :courier, :image_url

    def initialize(hash)
      @id          =         hash['id']
      @status      =         hash['status']
      @complete    =         hash['complete']
      @quote_id    =         hash['quote_id']
      @fee         =         hash['fee']
      @currency    =         hash['currency']
      @manifest    =         hash['manifest']
      @pickup      =         hash['pickup']
      @dropoff     =         hash['dropoff']
      @courier     =         hash['courier']
      @image_url   =  urlify hash['image_href']
      @created_at  = timeify hash['created']
      @updated_at  = timeify hash['updated']
      @pickup_eta  = timeify hash['pickup_eta']
      @dropoff_eta = timeify hash['dropoff_eta']
    end

    def delivered?
      status == 'delivered'
    end
  end
end