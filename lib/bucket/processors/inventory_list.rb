module Bucket
  module Processors
    class InventoryList
      def process(message)
        response if triggers.match(message.text)
      end

      private

      def triggers
        /^(?:
           inv|
        inventory|
        items|
        list\sitems|
        what\sare\syou\scarrying|
        what\sare\syou\sholding|
          )$/ix
      end

      def response
        [
          'I am carrying $inventory',
          'I am holding $inventory',
          'I have $inventory',
          '/me is carrying $inventory',
          '/contains $inventory',
        ].sample
      end
    end
  end
end
