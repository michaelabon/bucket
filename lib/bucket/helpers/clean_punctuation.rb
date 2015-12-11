module Bucket
  module Helpers
    module CleanPunctuation
      def self.clean_punctuation(text)
        return '' unless text

        text.gsub(/[.,!?'"()\[\]{}]/, '')
      end
    end
  end
end
