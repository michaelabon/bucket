module Bucket
  module Processors
    class FactAdd
      def process(message)
        return unless message.addressed && trigger.match(message.text)

        Fact.find_or_create_by(trigger: $1, result: $2)

        "OK, #{message.user_name}"
      end

      private

      def trigger
        @trigger ||= Regexp.new(/
          ^ "(.*?)"
          \s+
          is
          \s+
          "(.*?)" $
        /ix,
                               )
      end
    end
  end
end
