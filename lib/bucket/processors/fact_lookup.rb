module Bucket
  module Processors
    class FactLookup
      def process(message)
        fact = Fact.find_by(trigger: message.text)

        fact.try(:result)
      end
    end
  end
end
