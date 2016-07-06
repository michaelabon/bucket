module Bucket
  module Helpers
    module Clean
      def self.clean(text)
        text = CleanCase.clean_case(text)
        text = CleanPunctuation.clean_punctuation(text)
        text
      end
    end
  end
end
