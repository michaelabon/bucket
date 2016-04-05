module Bucket
  module Processors
    class MoveAssHyphens
      def process(message)
        return nil unless message.text.match(regexp)

        MessageResponse.new(
          text: message.text.gsub(regexp, '\k<adj> ass-\k<noun>')
        )
      end

      private

      def regexp
        @regexp ||= /(?<adj>[[:word:]]+)-ass (?<noun>[[:word:]]+)/
      end
    end
  end
end
