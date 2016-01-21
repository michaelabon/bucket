module Bucket
  module Helpers
    module CleanCase
      def self.clean_case(text)
        return '' unless text

        text.mb_chars.downcase.to_s
      end
    end
  end
end
