module Bucket
  module Postprocessors
    class ReplaceItem
      def process(message_response)
        return if message_response.try(:text).blank?

        while message_response.text.match(matching_regex)
          message_response.text.sub!(matching_regex, item)
        end
      end

      private

      def item
        return default_item if items.empty?

        new_item = items.shift
        new_item.destroy
        new_item.what
      end

      def items
        @items ||= Item.order('RANDOM()').to_a
      end

      def default_item
        'bananas'
      end

      def matching_regex
        @matching_regex ||= /\$(give)?item/
      end
    end
  end
end
