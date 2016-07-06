module Bucket
  module Processors
    class InventoryAdd
      def process(message)
        if (match = common_triggers.match(message.text))
          cleaned = clean_item(match, message.user_name)
          Item.create!(
            what: cleaned,
            placed_by: message.user_name
          )

          return MessageResponse.new(
            text: "is now carrying #{cleaned}",
            verb: '<action>'
          )
        elsif (match = addressed_triggers.match(message.text))
          cleaned = clean_item(match, message.user_name)
          Item.create!(
            what: cleaned,
            placed_by: message.user_name
          )

          return MessageResponse.new(
            text: "is now carrying #{cleaned}",
            verb: '<action>'
          )
        end

        nil
      end

      private

      def common_triggers
        /^(?:
           puts \s (?<item>\S.+) \s in \s (?:the \s)? Bucket\b
        | (?:gives|hands) \s (?<item>\S.+) \s to \s Bucket\b
        | (?:gives|hands) \s Bucket \s (?<item>\S.+)
          )/ix
      end

      def addressed_triggers
        /^(?:
           (?:have|take) \s (?<item>(?:a|an|this|these) \s \S.+)
          )/ix
      end

      def clean_item(match, speaker)
        match[:item]
          .sub(/\b(?:her|his|their)\b/, "#{speaker}'s")
          .sub(/[!?. ]+$/, '')
      end
    end
  end
end
