module Bucket
  module Processors
    class ReverseTheFucking
      def process(message)
        return nil unless triggered?(message)

        if message.text.match regexp
          MessageResponse.new(
            text: message.text.sub(regexp, 'fucking the')
          )
        end
      end

      private

      def triggered?(message)
        message.text.scan(regexp).count == 1
      end

      def regexp
        @regexp ||= /the fucking/
      end
    end
  end
end
