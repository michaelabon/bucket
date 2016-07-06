module Bucket
  module Processors
    class SilenceActivate
      DEFAULT_SILENCE = 60.minutes

      def process(message)
        return unless triggered(message)

        SilenceRequest.create!(
          requester: message.user_name,
          silence_until: Time.zone.now + DEFAULT_SILENCE
        )

        response_text = "Okay, #{message.user_name}. Be back in a bit."
        MessageResponse.new(text: response_text)
      end

      private

      def triggered(message)
        message.addressed? &&
          message.text.match(/
            ^(?:go \s away|shut \s up)$
          /ix)
      end
    end
  end
end
