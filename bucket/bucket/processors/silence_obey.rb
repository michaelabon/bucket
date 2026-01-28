module Bucket
  module Processors
    # Enforces active silence requests by blocking all responses.
    #
    # Runs early in the processor chain to short-circuit processing
    # when Bucket has been told to be quiet.
    class SilenceObey
      def process(_message)
        BlankMessageResponse.new if SilenceRequest.request_active?
      end
    end
  end
end
