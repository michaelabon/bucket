module Bucket
  module Processors
    class ForgetNoun
      # @param [Message] message
      def process(message)
        return unless message.addressed?
        return unless (match = real_triggers.match(message.text))

        noun_to_forget = match.captures.detect { |x| x }
        if Noun.where(what: noun_to_forget).exists?
          Noun.where(what: noun_to_forget).destroy_all
          reply_found(noun_to_forget)
        else
          reply_not_found(noun_to_forget)
        end
      end

      private

      def reply_found(noun_to_forget)
        MessageResponse.new(
          text: "Okay, $who, '#{noun_to_forget}' is no longer a noun.",
          verb: '<reply>'
        )
      end

      def reply_not_found(noun_to_forget)
        MessageResponse.new(
          text: "I'm sorry, $who, but '#{noun_to_forget}' is not a noun that I know of.",
          verb: '<reply>'
        )
      end

      def real_triggers
        /^(?:
            (?:forget|remove|delete) \s value \s \$noun \s (?:from \s)? (\w+) |
            (?:forget|remove|delete) \s value \s (\w+) \s (?:from \s)? \$noun
        )$/ix
      end
    end
  end
end
