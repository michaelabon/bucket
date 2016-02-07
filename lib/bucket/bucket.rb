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
        ::Bucket::Processors::SilenceDeactivate.new(default_muzzle),
        ::Bucket::Processors::SilenceObey.new(default_muzzle),
        ::Bucket::Processors::SilenceActivate.new(default_muzzle),
        ::Bucket::Processors::FactDelete.new,
        ::Bucket::Processors::InventoryList.new,
        ::Bucket::Processors::FactAdd.new,
        ::Bucket::Processors::FactLookup.new,
        ::Bucket::Processors::InventoryAdd.new
      ]
    end

    def default_postprocessors
      [
        ::Bucket::Postprocessors::Inventory.new,
        ::Bucket::Postprocessors::Who.new,
        ::Bucket::Postprocessors::PerformAction.new,
        ::Bucket::Postprocessors::HtmlEncode.new
      ]
    end

    def default_muzzle
      @muzzle ||= Muzzle::Muzzle.new(clasp_repo: Rails.configuration.clasp_repo)
    end
  end
end
