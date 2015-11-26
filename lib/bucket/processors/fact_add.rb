module Bucket
  module Processors
    class FactAdd
      def process(message)
        return unless message.addressed? && (
          message.text =~ /(.*?)\s+(is|are)\s+(.*)/i ||
          message.text =~ /(.*?)\s+(<\w+>)\s*(.*)/i
        )

        trigger = $1
        verb = $2
        result = $3

        verb.gsub!(/^<|>$/, '') unless ['<action>', '<reply>'].include? verb

        Fact.find_or_create_by(trigger: trigger, verb: verb, result: result)

        MessageResponse.new(text: "OK, #{message.user_name}")
      end

      private

      def trigger
        @trigger ||= Regexp.new(/
          ^ (.*?)
          \s+
          (<(?:action|reply)>)
          \s+
          (.*?) $
        /ix
                               )
      end
    end
  end
end
