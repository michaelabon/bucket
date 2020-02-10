module Bucket
  module Processors
    class LearnNoun
      # @param [Message] message
      def process(message)
        return unless message.addressed?
        return unless (match = real_triggers.match(message.text))

        new_noun = match.captures.detect { |x| x }

        MessageResponse.new(
          text: "Okay, $who, '#{new_noun}' is now a noun.",
          verb: '<reply>'
        )
      end

      private

      def real_triggers
        /^(?:
          add \s value \s \$noun \s (\w+) |
          add \s value \s (\w+) \s \$noun |
          add \s (\w+) \s to \s \$noun
        )$/ix
      end
    end
  end
end
