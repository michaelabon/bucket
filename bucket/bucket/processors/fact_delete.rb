module Bucket
  module Processors
    # Removes facts when users ask Bucket to forget something.
    #
    # Sometimes facts become outdated or users teach Bucket something they regret.
    # This lets them clean up by saying "delete X".
    class FactDelete
      def process(message)
        return nil unless message.addressed? && (
          message.text =~ /^delete (.*?)$/i
        )

        trigger = Helpers::Clean.clean($1)

        facts = Fact.where(trigger:)
        return failure(message) if facts.count <= 0

        facts.destroy_all
        success(message, trigger)
      end

      def failure(message)
        MessageResponse.new(
          text: "I don't know what you're talking about, #{message.user_name}."
        )
      end

      def success(message, trigger)
        MessageResponse.new(
          text: "OK, #{message.user_name}. I have deleted #{trigger}."
        )
      end
    end
  end
end
