module Bucket
  module Processors
    class SilenceObey
      def process(_message)
        BlankMessageResponse.new if SilenceRequest.request_active?
      end
    end
  end
end
