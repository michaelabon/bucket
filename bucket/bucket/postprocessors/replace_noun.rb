module Bucket
  module Postprocessors
    # Substitutes `$noun` with a random noun from the user-taught pool.
    #
    # This adds variety to responses. Users can escape as `\$noun` when
    # they want the literal string in a response.
    class ReplaceNoun
      # Only replace instances of $noun with a random noun.
      # If it contains \$noun, then Bucket or whoever created the response
      # wants Bucket to respond with $noun directly.
      def process(message_response)
        message_response&.text&.gsub!(
          unescaped_noun_variable,
          random_noun,
        )
        message_response&.text&.gsub!(
          escaped_noun_variable,
          '$noun',
        )
      end

      private

      # Match $noun without matching \$noun
      def unescaped_noun_variable
        @unescaped_noun_variable ||= /
          (?<!\\)     # Negative lookbehind for `\`.
          \$noun      # This `\` escapes the `$` character.
        /x
      end

      # Match \$noun
      def escaped_noun_variable
        @escaped_noun_variable ||= /
          \\      # literal `\`
          \$      # literal `$`
          noun
        /x
      end

      def random_noun
        Noun.pluck(:what).sample || 'box'
      end
    end
  end
end
