module Bucket
  module Helpers
    module MakeList
      def self.make_list(items)
        case items.count
        when 0
          '[none]'
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
