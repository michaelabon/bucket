module Bucket
  module Helpers
    module Clean
      def self.clean(text)
        helpers.reduce(text) { |memo, helper| helper.clean(memo) }
      end

      def self.helpers
        [
          CleanPunctuation,
          CleanCase,
        ]
      end
    end
  end
end
