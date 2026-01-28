module Bucket
  module Preprocessors
    # Normalizes whitespace in incoming messages.
    #
    # Users may paste text with extra spaces or leading/trailing whitespace.
    # Normalizing this ensures trigger matching works consistently
    # regardless of how the message was formatted.
    class CleanWhitespace
      def process(message)
        message.text.gsub!(/\s\s+/, ' ')
        message.text.strip!
      end
    end
  end
end
