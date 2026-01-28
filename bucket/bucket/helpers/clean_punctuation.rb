module Bucket
  module Helpers
    # Strips punctuation for trigger matching.
    module CleanPunctuation
      def self.clean(text)
        return '' unless text

        text.gsub(/[.,!?'"()\[\]{}‘’“”]/, '')
      end
    end
  end
end
