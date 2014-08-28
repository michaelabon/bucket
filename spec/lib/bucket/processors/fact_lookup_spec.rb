require 'rails_helper'

describe Bucket::Processors::FactLookup do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:message) { Message.new(text: 'alpha') }

    context 'fact exists' do
      before do
        create(:fact, trigger: 'alpha', result: 'bravo')
      end

      it 'returns the corresponding response' do
        message_response = processor.process(message)

        expect(message_response).to eq 'bravo'
      end
    end

    context 'fact does not exist' do
      specify do
        message_response = processor.process(message)

        expect(message_response).to eq nil
      end
    end

    context 'message has no text' do
      before do
        message.text = nil
      end

      specify do
        message_response = processor.process(message)

        expect(message_response).to eq nil
      end
    end
  end
end
