module Bucket
  module Helpers
    module CleanCase
      def self.clean(text)
        return '' unless text

        text.mb_chars.downcase.to_s
      end
    end
  end
end
