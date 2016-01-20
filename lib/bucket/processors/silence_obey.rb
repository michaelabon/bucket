module Bucket
  module Processors
    class SilenceObey
      def process(_message)
        return MessageResponse.new(text: nil) if SilenceRequest.request_active?
      end
    end
  end
end
