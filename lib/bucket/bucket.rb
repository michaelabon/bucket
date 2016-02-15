module Bucket
  include Bucket::Helpers

  class Bucket
    def initialize(
      preprocessors: default_preprocessors,
      processors: default_processors,
      postprocessors: default_postprocessors
    )
      @preprocessors = preprocessors
      @processors = processors
      @postprocessors = postprocessors
    end

    # Public: Orchestrates the message processing.
    #
    # Only one processor will be able to respond to each message:
    # A processor will either return a MessageResponse if it handles a message
    # or it will return nil if it will defer to lower-priority processors.
    # The processor is responsible for knowing if it can handle a message.
    #
    # Pre-processors will clean up the message.
    # Post-processors will clean up the response.
    # Every pre- and post-processor will be executed in order.
    #
    # Returns the message response String if the message deserves a response,
    # or nil.
    def process(message)
      message_response = nil

      preprocessors.each do |preprocessor|
        preprocessor.process(message)
      end

      processors.each do |processor|
        message_response = processor.process(message)

        break message_response if message_response
      end

      if message_response
        message_response.user_name = message.user_name
        postprocessors.each do |postprocessor|
          postprocessor.process(message_response)
        end
      end

      message_response.try(:text)
    end

    private

    attr_reader :preprocessors, :processors, :postprocessors

    def default_preprocessors
      [
        ::Bucket::Preprocessors::HtmlDecode.new,
        ::Bucket::Preprocessors::CleanWhitespace.new,
        ::Bucket::Preprocessors::AddressedToBucket.new
      ]
    end

    def default_processors
      [
        ::Bucket::Processors::IgnoreBots.new,
        ::Bucket::Processors::SilenceDeactivate.new,
        ::Bucket::Processors::SilenceObey.new,
        ::Bucket::Processors::SilenceActivate.new,
        ::Bucket::Processors::FactDelete.new,
        ::Bucket::Processors::InventoryList.new,
        ::Bucket::Processors::FactAdd.new,
        ::Bucket::Processors::FactLookup.new,
        ::Bucket::Processors::InventoryAdd.new
      ]
    end

    def default_postprocessors
      [
        ::Bucket::Postprocessors::ReplaceInventory.new,
        ::Bucket::Postprocessors::ReplaceItem.new,
        ::Bucket::Postprocessors::ReplaceWho.new,
        ::Bucket::Postprocessors::PerformAction.new,
        ::Bucket::Postprocessors::EncodeHtml.new
      ]
    end
  end
end
