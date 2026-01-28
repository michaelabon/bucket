module Bucket
  module Helpers
    module CleanCase
      def self.clean(text)
        return '' unless text

        text.downcase
      end
    end
  end
end
