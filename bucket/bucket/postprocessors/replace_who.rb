module Bucket
  module Postprocessors
    class ReplaceWho
      def process(message_response)
        return unless message_response&.text && message_response&.user_name

        message_response.text.gsub!(/\$who/, message_response.user_name)
      end
    end
  end
end
