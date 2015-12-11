module Bucket
  module Preprocessors
    class CleanWhitespace
      def process(message)
        message.text.gsub!(/\s\s+/, ' ')
        message.text.strip!
      end
    end
  end
end
