module Bucket
  module Postprocessors
    class Inventory
      def process(message_response)
        return unless message_response.try(:text)

        message_response.text.sub!(/\$inventory/, inventory)

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
