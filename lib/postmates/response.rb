require_relative 'quote'
require_relative 'delivery'

module Postmates
  module Response
    class << self
      def build(body)
        kind = body['object'] || body['kind']
        case kind
        when 'list'
          body['data'].map { |del| Delivery.new(del) }.tap do |list|
            list.instance_variable_set(:@total_count, body['total_count'])
            list.instance_variable_set(:@next_href, body['next_href'])
            list.class.module_eval { attr_reader :total_count, :next_href }
          end
        when 'delivery'
          Delivery.new(body)
        when 'delivery_quote'
          Quote.new(body)
        end
      end
    end
  end
end