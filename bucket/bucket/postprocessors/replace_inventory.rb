module Bucket
  module Postprocessors
    # Substitutes `$inventory` with Bucket's current inventory list.
    #
    # Allows fact responses to dynamically include what Bucket is carrying,
    # so users can teach responses like "Bucket is holding $inventory".
    class ReplaceInventory
      def process(message_response)
        return unless message_response.try(:text)

        message_response.text.sub!('$inventory', inventory)

        nil
      end

      private

      def inventory
        items = Item.order(:created_at).pluck(:what)

        Helpers::MakeList.make_list(items)
      end
    end
  end
end
