module Bucket
  module Postprocessors
    class ReplaceNoun
      def process(message_response)
        message_response&.text&.gsub!(/\$noun/, random_noun)
      end

      private

      def random_noun
        Noun.all.pluck(:what).sample || 'box'
      end
    end
  end
end
