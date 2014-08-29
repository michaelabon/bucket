module Bucket
  class Bucket
    def initialize(
      preprocessors: default_preprocessors,
      processors: default_processors
    )
      @preprocessors = preprocessors
      @processors = processors
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

      result
    end

    private

    attr_reader :preprocessors, :processors

    def default_preprocessors
      [
        ::Bucket::Preprocessors::AddressedToBucket.new,
      ]
    end

    def default_processors
      [
        ::Bucket::Processors::FactAdd.new,
        ::Bucket::Processors::FactLookup.new,
      ]
    end
  end
end
