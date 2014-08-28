require 'rails_helper'

describe Bucket::Processors::FactAdd do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:message) { Message.new(text: '"X" is "Y"', user_name: 'M2K') }

    it 'adds the fact' do
      processor.process(message)

      expect(Fact.find_by(trigger: 'X').result).to eq 'Y'
    end

    it 'acknowledges the speaker’s command' do
      result = processor.process(message)

      expect(result).to eq 'OK, M2K'
    end
  end
end
