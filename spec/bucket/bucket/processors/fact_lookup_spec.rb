require 'rails_helper'

describe Bucket::Processors::FactLookup do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:message) { Message.new(text: 'alpha') }

    context 'when the fact exists' do
      before do
        create(:fact, trigger: 'alpha', result: 'bravo', verb: '<verb>')
      end

      it 'returns the corresponding response' do
        message_response = processor.process(message)

        expect(message_response.text).to eq 'bravo'
      end

      it 'returns the fact’s verb' do
        message_response = processor.process(message)

        expect(message_response.verb).to eq '<verb>'
      end

      it 'returns the fact’s trigger' do
        message_response = processor.process(message)

        expect(message_response.trigger).to eq 'alpha'
      end
    end

    context 'when the fact does not exist' do
      specify do
        message_response = processor.process(message)

        expect(message_response).to eq nil
      end
    end

    context 'when the message has no text' do
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
