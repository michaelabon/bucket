module Bucket
  module Processors
    class InventoryList
      def process(message)
        return unless triggered?(message)

        MessageResponse.new(**response)
      end

      private

      def triggered?(message)
        cleaned_message = Helpers::CleanPunctuation.clean(message.text)

        message.addressed? && triggers.match(cleaned_message)
      end

      def triggers # rubocop:disable Metrics/MethodLength
        /^(?:
          inv |
          inventory |
          items |
          list \s inventory |
          list \s items |
          list \s your \s items |
          list \s your \s inventory |
          what \s are \s you \s carrying |
          what \s are \s you \s holding |
          what \s are \s your \s items |
          what \s do \s you \s carry |
          what \s do \s you \s have
        )$/ix
      end

      def response
        [
          { text: 'I am carrying $inventory', verb: '<reply>' },
          { text: 'I am holding $inventory', verb: '<reply>' },
          { text: 'I have $inventory', verb: '<reply>' },
          { text: 'is carrying $inventory', verb: '<action>' },
        ].sample
      end
    end
  end
end
