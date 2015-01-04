require_relative 'quote'
require_relative 'delivery'

module Postmates
  module Response
    class << self
      def build(body)
        kind = body['object'] || body['kind']
        case kind
        when 'list'           ; body['data'].map { |del| Delivery.new(del) }
        when 'delivery'       ; Delivery.new(body)
        when 'delivery_quote' ; Quote.new(body)
        end
      end
    end
  end
end