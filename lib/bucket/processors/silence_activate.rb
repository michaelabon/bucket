module Bucket
  module Processors
    class SilenceActivate
      DEFAULT_SILENCE = 60.minutes

      def initialize(muzzle)
        @muzzle = muzzle
      end

      def process(message)
        return unless triggered(message)

        muzzle.clasp(falls_off_at: Time.zone.now + DEFAULT_SILENCE)

        response_text = "Okay, #{message.user_name}. Be back in a bit."
        MessageResponse.new(text: response_text)
      end

      private

      attr_reader :muzzle

      def triggered(message)
        message.addressed? &&
          message.text.match(/
            ^(?:go \s away|shut \s up)$
          /ix)
      end
    end
  end
end
