module Bucket
  module Processors
    class InventoryList
      def process(message)
        trigger = Helpers::CleanPunctuation.clean_punctuation(message.text)

        if message.addressed? && triggers.match(trigger)
          return MessageResponse.new(**response)
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
          { text: 'I am carrying $inventory', verb: '<reply>' },
          { text: 'I am holding $inventory', verb: '<reply>' },
          { text: 'I have $inventory', verb: '<reply>' },
          { text: 'is carrying $inventory', verb: '<action>' },
          { text: 'contains $inventory', verb: '<action>' }
        ].sample
      end
    end
  end
end
