module Bucket
  module Postprocessors
    class Inventory
      def process(message_response)
        message_response.sub(/\$inventory/, inventory)
      end

      private

      def inventory
        items = Item.order(:created_at).pluck(:what)
        Helpers::MakeList.make_list(items)
      end
    end
  end
end
