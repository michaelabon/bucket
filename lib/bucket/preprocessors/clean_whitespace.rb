module Bucket
  module Preprocessors
    class CleanWhitespace
      def process(message)
        message.text.gsub!(/\s\s+/, ' ')
        message.text.gsub!(/^\s+/, '')
        message.text.gsub!(/\s+$/, '')
      end
    end
  end
end
