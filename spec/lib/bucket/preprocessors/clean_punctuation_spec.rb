require 'rails_helper'

describe Bucket::Preprocessors::CleanPunctuation do
  let(:processor) { described_class.new }

  describe '#process' do
    %w(    ? ! . ,    ).each do |punc|
      it "strips #{punc}" do
        message = Message.new(text: "alpha#{punc}")

        processor.process(message)

        expect(message.text).to eq 'alpha'
      end
    end

    it 'does not strip quotation marks' do
      message = Message.new(text: 'alpha"')

      processor.process(message)

      expect(message.text).to eq 'alpha"'
    end
  end
end
