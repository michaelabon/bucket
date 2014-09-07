module Bucket
  module Preprocessors
    class HtmlDecode
      def process(message)
        message.text = CGI.unescapeHTML(message.text) if message.text.present?

        nil
      end
    end
  end
end
