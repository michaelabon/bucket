module Bucket
  module Processors
    class RandomNounLister
      def process(message)
        return unless message.addressed? && valid_trigger?(message.text)

        nouns = Noun.order(:what).pluck(:what)

        nouns_as_list = Helpers::MakeList.make_list(nouns.to_a)

        MessageResponse.new(text: "\\$noun: #{nouns_as_list}")
      end

      private

      def valid_trigger?(text)
        valid_triggers.include?(text)
      end

      def valid_triggers
        [
          'list values $noun',
          'list values for $noun',
          'list values of $noun',
          'list the values for $noun',
          'list the values of $noun',
          'what are the values of $noun',
          'what are the values for $noun',
        ]
      end
    end
  end
end
