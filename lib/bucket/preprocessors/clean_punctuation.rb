module Bucket
  module Preprocessors
    class CleanPunctuation
      def process(message)
        message.text.gsub!(/[?!.,]$/, '')
      end
    end
  end
end
