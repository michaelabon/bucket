module Bucket
  module Postprocessors
    class ReplaceItem
      def process(message_response)
        return if message_response.try(:text).blank?

        while message_response.text.include?('$item')
          message_response.text.sub!('$item', item)
        end
      end

      private

      def item
        items.shift || default_item
      end

      def items
        @items ||= Item.order('RANDOM()').pluck(:what)
      end

      def default_item
        'bananas'
      end
    end
  end
end
