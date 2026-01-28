module Bucket
  module Processors
    # Retrieves a random matching fact for the message.
    #
    # This is Bucket's primary response mechanism.
    # When someone says something that matches a fact's trigger,
    # Bucket responds with one of the learned responses
    # (chosen randomly if multiple exist).
    class FactLookup
      def process(message)
        trigger = Helpers::Clean.clean(message.text)
        fact = Fact.where(trigger:).order(Arel.sql('RANDOM()')).first
        return nil unless fact.try(:result)

        MessageResponse.new(
          text: fact.result,
          trigger: message.text,
          verb: fact.verb
        )
      end
    end
  end
end
