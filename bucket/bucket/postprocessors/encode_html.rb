module Bucket
  module Postprocessors
    # Encodes special characters for safe display in Slack.
    #
    # Response text may contain characters that Slack interprets specially.
    # Encoding them prevents unintended formatting and potential injection
    # of Slack markup.
    class EncodeHtml
      def process(message_response)
        return if message_response&.text.blank?

        message_response.text.gsub!('&', '&amp;')
        message_response.text.gsub!('<', '&lt;')
        message_response.text.gsub!('>', '&gt;')

        nil
      end
    end
  end
end
