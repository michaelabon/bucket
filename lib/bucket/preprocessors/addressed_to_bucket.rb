module Bucket
  module Preprocessors
    class AddressedToBucket
      def process(message)
        return unless addressed_regex.match(message.text)

        message.addressed = true
        message.text.sub!(addressed_regex, '')

        nil
      end

      private

      def addressed_regex
        @addressed_regex ||= Regexp.new(/
          ^ Bucket    # If the line starts with the bots nickname
          [:,]\s*     # and is followed by a colon or comma,
          |           # --or--
          ^ @         # If the line starts with an at-symbol
          Bucket      # the nickname
          \s+         # and whitespace
          |           # --or--
          ,\s+        # If the line ends with a comma, then whitespace
          Bucket      # then the bots nickname
          \W*$        # then the end of the line
          /ix
                                       )
      end
    end
  end
end
