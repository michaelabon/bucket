module Bucket
  module Processors
    # Implements the xkcd 37 joke: "X-ass Y" becomes "X ass-Y".
    #
    # A tribute to https://xkcd.com/37/ where the hyphen in phrases
    # like "big-ass car" gets moved to create "big ass-car".
    class MoveAssHyphens
      def process(message)
        return nil unless message.text.match(regexp)

        MessageResponse.new(
          text: message.text.gsub(regexp, '\k<adj> ass-\k<noun>'),
        )
      end

      private

      def regexp
        @regexp ||= /(?<adj>[[:word:]]+)-ass (?<noun>[[:word:]]+)/
      end
    end
  end
end
