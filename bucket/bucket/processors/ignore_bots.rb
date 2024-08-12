module Bucket
  module Processors
    class IgnoreBots
      def process(message)
        BlankMessageResponse.new if bot_speaker?(message)
      end

      private

      def bot_speaker?(message)
        ignored_user_names.include? message.user_name
      end

      def ignored_user_names
        @ignored_user_names ||= Rails.configuration.ignored_user_names.split(',')
      end
    end
  end
end
