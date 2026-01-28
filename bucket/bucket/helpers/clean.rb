module Bucket
  module Helpers
    # Normalizes text for consistent fact trigger matching.
    #
    # Users type triggers inconsistently ("Hello!", "hello", "HELLO?"),
    # but they expect Bucket to recognize them as the same.
    # This helper strips punctuation and case
    # so "What is X?" matches a fact stored as "what is x".
    module Clean
      def self.clean(text)
        helpers.reduce(text) { |memo, helper| helper.clean(memo) }
      end

      def self.helpers
        [
          CleanPunctuation,
          CleanCase,
        ]
      end
    end
  end
end
