# Postmates
[![Build Status](https://travis-ci.org/O-I/postmates.svg?branch=master)](https://travis-ci.org/O-I/postmates)
[![Coverage Status](https://img.shields.io/coveralls/O-I/postmates.svg)](https://coveralls.io/r/O-I/postmates?branch=master)

Ruby wrapper for the [Postmates API](https://postmates.com/developer/docs).

## Installation

`gem install 'postmates'` or add `gem 'postmates'` to your Gemfile and `bundle`.

## Configuration

You'll need an API key and your customer ID. You can sign up to register your app [here](https://postmates.com/developer/register). Just want to test things out? Postmates has you covered with a [test key and customer account](https://postmates.com/developer/testing).

```ruby
# Create a new Postmates client
@client = Postmates.new

# Set basic config variables
@client.configure do |config|
  config.api_key = 'YOUR_API_KEY'
  config.customer_id = 'YOUR_CUSTOMER_ID'
end

# Or do some more advanced stuff
@client.configure do |config|
  # Get full Faraday responses instead of Ruby objects representing the body
  config.raw_response = true
  # Ensure consistent fields & formats by specifying a version in the header
  config.headers.merge!('X-Postmates-Version' => 20140825)
  # Work with a possible future version of the API
  config.api_url = 'https://api.postmates.com/v2/'
end

# And switch back to the defaults easily
@client.reset
```

## Usage

Descriptions and examples of the supported actions are below. For a more detailed explanation of available endpoints and an exhaustive list of the properties each response returns, check out the official Postmates developer [documentation](https://postmates.com/developer/docs).

### Customer Deliveries Endpoints

#### POST /v1/customers/:customer_id/delivery_quotes

Get a delivery quote. Returns a `Postmates::Quote` object.

```ruby
from  = "20 McAllister St, San Francisco, CA"
to    = "101 Market St, San Francisco, CA"
quote = @client.quote(pickup_address: from, dropoff_address: to)

quote.fee                          # => 1350
quote.currency                     # => "usd"
format = '%m/%d/%Y %I:%M:%S%p'     # all times are returned in UTC
quote.expires_at.strftime(format)  # => "01/05/2015 09:35:28PM"
quote.expired?                     # => false
```

#### POST /v1/customers/:customer_id/deliveries

Create a delivery. Returns a `Postmates::Delivery` object.

```ruby
# all fields required except where noted
package = { 
            manifest: "a box of kittens",
            pickup_name: "The Warehouse",
            pickup_address: "20 McAllister St, San Francisco, CA",
            pickup_phone_number: "555-555-5555",
            pickup_business_name: "Optional Pickup Business Name, Inc.",
            pickup_notes: "Optional note that this is Invoice #123",
            dropoff_name: "Alice",
            dropoff_address: "101 Market St, San Francisco, CA",
            dropoff_phone_number: "415-555-1234",
            dropoff_business_name: "Optional Dropoff Business Name, Inc.",
            dropoff_notes: "Optional note to ring the bell",
            quote_id: "dqt_K9LFfpSZCdAJsk" # optional
          }
delivery = @client.create(package)

delivery.id         # => "del_K9gEsDNuPJ-lLV"
delivery.status     # => "pending"
delivery.delivered? # => false
delivery.pickup     # a hash representing pickup information
delivery.dropoff    # a hash representing dropoff information
```

#### GET /v1/customers/:customer_id/deliveries

Fetch a list of all deliveries for a customer. Returns an array of `Postmates::Delivery` objects.

```ruby
my_deliveries = @client.list
my_ongoing_deliveries = @client.list(filter: 'pending')

# If the result is too large for one response
# there are a few meta-attributes you can call on the returned array
# Here's a simulated example of a paginated response:
deliveries = @client.list(limit: 2)
deliveries.size        # => 2 (number of deliveries in the returned array)
deliveries.total_count # => 6 (number of total deliveries)
deliveries.next_href   # a URI object representing the path to the next page
```

#### GET /v1/customers/:customer_id/deliveries/:delivery_id

Fetch a single delivery by id. Returns a `Postmates::Delivery` object.

```ruby
@client.retrieve('del_K9gEsDNuPJ-lLV')
```

#### POST /v1/customers/:customer_id/deliveries/:delivery_id/cancel

Cancel an ongoing delivery prior to pickup. Returns a `Postmates::Delivery` object.

```ruby
@client.cancel('del_K9gEsDNuPJ-lLV')
```

#### POST /v1/customers/:customer_id/deliveries/:delivery_id/return

Cancel an ongoing delivery that was already picked up and create a delivery that is a reverse of the original. The items will get returned to the original pickup location. Returns a `Postmates::Delivery` object.

```ruby
@client.return('del_K9gEsDNuPJ-lLV')
```

#### POST /v1/customers/:customer_id/deliveries/:delivery_id

Add a tip (in cents) to a delivery (after the delivery has been completed). Returns a `Postmates::Delivery` object.

```ruby
@client.add_tip('del_K9gEsDNuPJ-lLV', tip_by_customer: 295)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/postmates/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
