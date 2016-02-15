module Bucket
  module Processors
    class IgnoreBots
      def process(message)
        if ignored_user_names.include? message.user_name
          return MessageResponse.new(text: '')
        end

        nil
      end

      private

      def ignored_user_names
        @ignored ||= Rails.application.secrets[:ignored_user_names]
      end
    end
  end
end
