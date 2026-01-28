module Bucket
  module Postprocessors
    # Substitutes `$item` and `$giveitem` with inventory items.
    #
    # `$item` inserts a random item name,
    # while `$giveitem` also removes that item from inventory.
    # This enables responses where Bucket "gives away" items it's holding.
    class ReplaceItem
      def process(message_response)
        return if message_response.try(:text).blank?

        # rubocop:todo Style/WhileUntilModifier
        while message_response.text.match(matching_regex)
          message_response.text.sub!(matching_regex, item)
        end
        # rubocop:enable Style/WhileUntilModifier
      end

      private

      def item
        return default_item if items.empty?

        new_item = items.shift
        new_item.destroy
        new_item.what
      end

      def items
        @items ||= Item.order(Arel.sql('RANDOM()')).to_a
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
