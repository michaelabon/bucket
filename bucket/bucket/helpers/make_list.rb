module Bucket
  # Shared utilities for text manipulation across the pipeline.
  module Helpers
    # Formats arrays as human-readable lists with proper Oxford comma handling.
    #
    # Bucket often needs to enumerate things
    # (inventory items, nouns)
    # in a natural way.
    # This helper produces grammatically correct lists
    # like "a, b, and c"
    # instead of raw array output.
    module MakeList
      def self.make_list(items) # rubocop:disable Metrics/MethodLength
        case items.count
        when 0
          'nothing'
        when 1
          items[0]
        when 2
          items.join(' and ')
        else
          last = items.pop
          items.join(', ') << ", and #{last}"
        end
      end
    end

    include MakeList
  end
end
