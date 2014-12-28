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
    # Returns a DeliveryQuote response
    def quote(options = {})
      post("customers/#{customer_id}/delivery_quotes", options)
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
    def create(options = {})
      post("customers/#{customer_id}/deliveries", options)
    end

    # GET /v1/customers/:customer_id/deliveries
    #
    # ?filter=ongoing
    #
    # Returns a list of Delivery objects
    def list(options = {})
      get("customers/#{customer_id}/deliveries", options)
    end

    # GET /v1/customers/:customer_id/deliveries/:delivery_id
    #
    # Returns a Delivery object
    def retrieve(delivery_id)
      get("customers/#{customer_id}/deliveries/#{delivery_id}")
    end

    # POST /v1/customers/:customer_id/deliveries/:delivery_id/cancel
    #
    # Returns a Delivery object
    def cancel(delivery_id)
      post("customers/#{customer_id}/deliveries/#{delivery_id}/cancel")
    end

    # POST /v1/customers/:customer_id/deliveries/:delivery_id/return
    #
    # Returns a Delivery object
    def return(delivery_id)
      post("customers/#{customer_id}/deliveries/#{delivery_id}/return")
    end
  end
end