module Bucket
  module Postprocessors
    class HtmlEncode
      def process(message_response)
        return if message_response.blank?

        message_response.gsub!('&', '&amp;')
        message_response.gsub!('<', '&lt;')
        message_response.gsub!('>', '&gt;')

        message_response
      end
    end
  end
end
