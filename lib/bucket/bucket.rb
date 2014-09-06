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
      result = nil

      preprocessors.each do |preprocessor|
        preprocessor.process(message)
      end

      processors.each do |processor|
        result = processor.process(message)

        break result if result
      end

      if result
        postprocessors.each do |postprocessor|
          result = postprocessor.process(result)
        end
      end

      result
    end

    private

    attr_reader :preprocessors, :processors, :postprocessors

    def default_preprocessors
      [
        ::Bucket::Preprocessors::AddressedToBucket.new,
      ]
    end

    def default_processors
      [
        ::Bucket::Processors::FactAdd.new,
        ::Bucket::Processors::FactLookup.new,
        ::Bucket::Processors::InventoryList.new,
      ]
    end

    def default_postprocessors
      [
        ::Bucket::Postprocessors::Inventory.new,
      ]
    end
  end
end
