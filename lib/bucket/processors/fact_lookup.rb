module Bucket
  module Processors
    class FactLookup
      def process(message)
        trigger = Helpers::Clean.clean(message.text)
        fact = Fact.where(trigger: trigger).order('RANDOM()').first
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
