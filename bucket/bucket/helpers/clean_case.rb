module Bucket
  module Helpers
    # Lowercases text for case-insensitive trigger matching.
    module CleanCase
      def self.clean(text)
        return '' unless text

        text.downcase
      end
    end
  end
end
