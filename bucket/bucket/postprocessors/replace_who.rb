module Bucket
  module Postprocessors
    # Substitutes `$who` with the username of who triggered the response.
    #
    # This lets fact responses address the person who triggered them,
    # making interactions feel more personal.
    class ReplaceWho
      def process(message_response)
        return unless message_response&.text && message_response.user_name

        message_response.text.gsub!('$who', message_response.user_name)
      end
    end
  end
end
