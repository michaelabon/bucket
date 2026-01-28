module Bucket
  module Processors
    # Teaches Bucket a new noun for `$noun` substitution.
    #
    # Users can expand the pool of random nouns that get substituted
    # into `$noun` placeholders in responses.
    class LearnNoun
      # @param [Message] message
      def process(message)
        return unless message.addressed?
        return unless (match = real_triggers.match(message.text))

        new_noun = match.captures.detect { |x| x }
        save_noun(new_noun, message.user_name)
        reply(new_noun)
      end

      private

      def save_noun(what, placed_by)
        Noun.create(
          what:,
          placed_by:,
        )
      end

      def reply(new_noun)
        MessageResponse.new(
          text: "Okay, $who, '#{new_noun}' is now a noun.",
          verb: '<reply>',
        )
      end

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
