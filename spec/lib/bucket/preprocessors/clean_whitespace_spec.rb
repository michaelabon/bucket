require 'spec_helper'

describe Bucket::Preprocessors::CleanWhitespace do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:message) { Message.new(text: " a \t b  ") }

    it 'collapses and strips whitespace' do
      processor.process(message)

      expect(message.text).to eq 'a b'
    end
  end
end
