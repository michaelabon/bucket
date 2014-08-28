module Bucket
  class Bucket
    def initialize(processors = default_processors)
      @processors = processors
    end

    def process(message)
      result = nil

      processors.each do |processor|
        result = processor.new.process(message)

        break result if result
      end

      result
    end

    private

    attr_reader :processors

    def default_processors
      [
        ::Bucket::Processors::FactAdd,
        ::Bucket::Processors::FactLookup,
      ]
    end
  end
end
