module Bucket
  module Preprocessors
    # Decodes HTML entities in incoming messages.
    #
    # Slack encodes special characters as HTML entities (e.g., `&amp;` for `&`).
    # We decode these early so processors see the actual characters users typed.
    class HtmlDecode
      def process(message)
        message.text = CGI.unescapeHTML(message.text) if message.text.present?

        nil
      end
    end
  end
end
