module Bucket
  module Postprocessors
    class HtmlEncode
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
