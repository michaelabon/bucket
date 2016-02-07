module Bucket
  module Processors
    class SilenceDeactivate
      def initialize(muzzle)
        @muzzle = muzzle
      end

      def process(message)
        return unless triggered(message)

        if @muzzle.clasped?
          @muzzle.unclasp
          response_text = "Thanks for inviting me back, #{message.user_name}!"
        else
          response_text = "But #{message.user_name}, I am already here."
        end

        MessageResponse.new(text: response_text)
      end

      private

      def triggered(message)
        message.addressed? &&
          message.text.match(/
            ^(?:unshut \s up|come \s back)$
          /ix)
      end
    end
  end
end
