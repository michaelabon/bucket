module Bucket
  module Postprocessors
    # Formats responses based on their verb type.
    #
    # Facts can have different verbs:
    # `<action>` for emotes,
    # `<reply>` for direct responses,
    # or custom verbs like "is" or "are".
    # This postprocessor transforms the raw response into the appropriate format
    # (e.g., wrapping actions in underscores for Slack's italic formatting).
    class PerformAction
      def process(message_response)
        return if message_response.verb.blank?

        case message_response.verb
        when '<action>'
          message_response.text = "_#{message_response.text}_"
        when '<reply>'
          nil
        else
          build_response(message_response)
        end

        nil
      end

      private

      def build_response(message_response)
        message_response.text = [
          message_response.trigger,
          message_response.verb,
          message_response.text,
        ].join(' ')
      end

      def processable?(message_response)
        message_response.verb.present? && message_response.verb != '<reply>'
      end
    end
  end
end
