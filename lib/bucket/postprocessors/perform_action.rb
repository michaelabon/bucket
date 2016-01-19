module Bucket
  module Postprocessors
    class PerformAction
      def process(message_response)
        return if message_response.verb.blank?

        case message_response.verb
        when '<action>'
          message_response.text = "_#{message_response.text}_"
        when '<reply>'
          nil
        else
          message_response.text = [
            message_response.trigger,
            message_response.verb,
            message_response.text
          ].join(' ')
        end

        nil
      end
    end
  end
end
