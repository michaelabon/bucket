module Bucket
  module Postprocessors
    class PerformAction
      def process(message_response)
        return unless message_response.verb == '<action>'

        message_response.text = "_#{message_response.text}_"

        nil
      end
    end
  end
end
