module Bucket
  module Processors
    class SilenceDeactivate
      def process(message)
        return unless triggered(message)

        if SilenceRequest.request_active?
          SilenceRequest.destroy_all
          return MessageResponse.new(text: "I'm back, $who!")
        end

        response_text = "But #{message.user_name}, I am already here."
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
