module Bucket
  module Processors
    class FactAdd
      def process(message)
        return unless message.addressed && trigger.match(message.text)

        Fact.find_or_create_by(trigger: $1, verb: $2, result: $3)

        MessageResponse.new(text: "OK, #{message.user_name}")
      end

      private

      def trigger
        @trigger ||= Regexp.new(/
          ^ "(.*?)"
          \s+
          (<(?:action|reply)>)
          \s+
          "(.*?)" $
        /ix,
                               )
      end
    end
  end
end
