module Bucket
  module Processors
    class InventoryList
      def process(message)
        trigger = Helpers::CleanPunctuation.clean_punctuation(message.text)

        if message.addressed? && triggers.match(trigger)
          return MessageResponse.new(text: response)
        end

        nil
      end

      private

      def triggers
        /^(?:
          inv|
          inventory|
          items|
          list\sitems|
          list\syour\sitems|
          list\syour\sinventory|
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
          '/contains $inventory'
        ].sample
      end
    end
  end
end
