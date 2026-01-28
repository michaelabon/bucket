module Bucket
  module Processors
    # Learns new facts when users teach Bucket.
    #
    # Users teach Bucket by addressing it with statements like "X is Y"
    # or "X <verb> Y".
    # This processor parses those patterns and stores them for later retrieval.
    class FactAdd
      def process(message)
        return nil unless message.addressed? && (
          message.text =~ /(.*?)\s+(<\w+>)\s*(.*)/i ||
          message.text =~ /(.*?)\s+(is|are)\s+(.*)/i
        )

        trigger = Helpers::Clean.clean($1)
        verb = $2
        result = $3

        verb.gsub!(/^<|>$/, '') unless ['<action>', '<reply>'].include? verb

        Fact.find_or_create_by(trigger:, verb:, result:)

        MessageResponse.new(text: "OK, #{message.user_name}")
      end
    end
  end
end
