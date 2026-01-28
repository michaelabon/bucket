module Bucket
  module Processors
    # Accepts items that users give to Bucket.
    #
    # Part of Bucket's playful personality is that it "holds" things
    # users give it.
    # This recognizes phrases like "gives X to Bucket" or "puts X in Bucket"
    # and adds the item to inventory.
    class InventoryAdd
      def process(message)
        # rubocop:disable Lint/DuplicateBranch
        if (match = common_triggers.match(message.text))
          handle_match(match, message)
        elsif (match = addressed_triggers.match(message.text))
          handle_match(match, message)
        end
        # rubocop:enable Lint/DuplicateBranch
      end

      private

      def handle_match(match, message)
        cleaned = clean_item(match, message.user_name)
        Item.create!(
          what: cleaned,
          placed_by: message.user_name,
        )

        MessageResponse.new(
          text: "is now carrying #{cleaned}",
          verb: '<action>',
        )
      end

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
