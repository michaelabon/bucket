module Bucket
  module Processors
    class SilenceObey
      def initialize(muzzle)
        @muzzle = muzzle
      end

      def process(_message)
        return MessageResponse.new(text: nil) if @muzzle.clasped?
      end
    end
  end
end
