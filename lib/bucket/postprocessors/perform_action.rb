module Bucket
  module Postprocessors
    class PerformAction
      def process(message_response)
        case message_response.verb
        when 'is'
          message_response.text = [
            message_response.trigger,
            message_response.verb,
            message_response.text,
          ].join(' ')
        when '<action>'
          message_response.text = "_#{message_response.text}_"
        end

        nil
      end
    end
  end
end
