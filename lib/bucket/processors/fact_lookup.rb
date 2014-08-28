module Bucket
  module Processors
    class FactLookup
      def process(message)
        fact = Fact.where(trigger: message.text).order("RANDOM()").first

        fact.try(:result)
      end
    end
  end
end
