module Bucket
  module Processors
    class ReverseTheFucking
      def process(message)
        return nil unless triggered?(message)
        return nil unless message.text.match?(regexp)

        MessageResponse.new(
          text: message.text.sub(regexp, 'fucking the')
        )
      end

      private

      def triggered?(message)
        message.text.scan(regexp).one?
      end

      def regexp
        @regexp ||= /the fucking/
      end
    end
  end
end
