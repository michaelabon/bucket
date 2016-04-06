module Bucket
  module Processors
    class ReverseTheFucking
      def process(message)
        return nil unless message.text.scan(regexp).count == 1

        if message.text.match regexp
          MessageResponse.new(
            text: message.text.sub(regexp, 'fucking the')
          )
        end
      end

      private

      def regexp
        @regexp ||= /the fucking/
      end
    end
  end
end
