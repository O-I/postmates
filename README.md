# Postmates
[![Build Status](https://travis-ci.org/O-I/postmates.svg?branch=master)](https://travis-ci.org/O-I/postmates)

Ruby wrapper for the [Postmates API](https://postmates.com/developer/docs).

## Installation

`gem install 'postmates'` or add `gem 'postmates'` to your Gemfile and `bundle`.

## Configuration

You'll need an API key and your customer ID. You can sign up to register your app [here](https://postmates.com/developer/register). Just want to test things out? Postmates has you [covered](https://postmates.com/developer/testing).

```ruby
@client = Postmates::Client.new

@client.configure do |config|
  config.api_key = 'YOUR_API_KEY'
  config.customer_id = 'YOUR_CUSTOMER_ID'
end
```

## Usage

Full documentation coming soon. In the meantime, check out Postmates' official developer [documentation](https://postmates.com/developer/docs) for more information.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/postmates/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request