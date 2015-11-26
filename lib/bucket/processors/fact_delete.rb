module Bucket
  module Processors
    class FactDelete
      def process(message)
        return unless message.addressed? && (
        message.text =~ /^delete (.*?)$/i
        )

        trigger = $1

        facts = Fact.where(trigger: trigger)
        if facts.count > 0
          facts.destroy_all
          return success(message, trigger)
        else
          return failure(message)
        end
      end

      def failure(message)
        MessageResponse.new(
          text: "I don't know what you're talking about, #{message.user_name}.",
        )
      end

      def success(message, trigger)
        MessageResponse.new(
          text: "OK, #{message.user_name}. I have deleted #{trigger}.",
        )
      end
    end
  end
end
