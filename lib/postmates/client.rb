require_relative 'quote'
require_relative 'delivery'
require_relative 'request'
require_relative 'connection'
require_relative 'configuration'

module Postmates
  class Client
    include Postmates::Request
    include Postmates::Connection
    include Postmates::Configuration

    def initialize
      reset
    end

    # POST /v1/customers/:customer_id/delivery_quotes
    #
    # pickup_address="20 McAllister St, San Francisco, CA"
    # dropoff_address="101 Market St, San Francisco, CA"
    #
    # Returns a Quote object or the raw Faraday response
    # if raw_response = true
    def quote(options = {})
      raw = post("customers/#{customer_id}/delivery_quotes", options)
      raw_response ? raw : Quote.new(raw.body)
    end

    # POST /v1/customers/:customer_id/deliveries
    #
    # manifest="a box of kittens"
    # pickup_name="The Warehouse"
    # pickup_address="20 McAllister St, San Francisco, CA"
    # pickup_phone_number="555-555-5555"
    # pickup_business_name="Optional Pickup Business Name, Inc."
    # pickup_notes="Optional note that this is Invoice #123"
    # dropoff_name="Alice"
    # dropoff_address="101 Market St, San Francisco, CA"
    # dropoff_phone_number="415-555-1234"
    # dropoff_business_name="Optional Dropoff Business Name, Inc."
    # dropoff_notes="Optional note to ring the bell"
    # quote_id=qUdje83jhdk
    #
    # Returns a Delivery object or the raw Faraday response
    # if raw_response = true
    def create(options = {})
      raw = post("customers/#{customer_id}/deliveries", options)
      raw_response ? raw : Delivery.new(raw.body)
    end

    # GET /v1/customers/:customer_id/deliveries
    #
    # ?filter=ongoing
    #
    # Returns a list of Delivery objects or the raw Faraday response
    # if raw_response = true
    def list(options = {})
      raw = get("customers/#{customer_id}/deliveries", options)
      raw_response ? raw : raw.body['data'].map { |del| Delivery.new(del) }
    end

    # GET /v1/customers/:customer_id/deliveries/:delivery_id
    #
    # Returns a Delivery object or the raw Faraday response
    # if raw_response = true
    def retrieve(delivery_id)
      raw = get("customers/#{customer_id}/deliveries/#{delivery_id}")
      raw_response ? raw : Delivery.new(raw.body)
    end

    # POST /v1/customers/:customer_id/deliveries/:delivery_id/cancel
    #
    # Returns a Delivery object or the raw Faraday response
    # if raw_response = true
    def cancel(delivery_id)
      raw = post("customers/#{customer_id}/deliveries/#{delivery_id}/cancel")
      raw_response ? raw : Delivery.new(raw.body)
    end

    # POST /v1/customers/:customer_id/deliveries/:delivery_id/return
    #
    # Returns a Delivery object or the raw Faraday response
    # if raw_response = true
    def return(delivery_id)
      raw = post("customers/#{customer_id}/deliveries/#{delivery_id}/return")
      raw_response ? raw : Delivery.new(raw.body)
    end
  end
end