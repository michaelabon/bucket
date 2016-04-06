require 'spec_helper'

describe Bucket::Processors::ReverseTheFucking do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:message) do
      Message.new(text: text)
    end

    context 'when message contains `the fucking`' do
      let(:text) { 'the fucking bus' }

      it 'repeats the message but reverses the trigger' do
        message_response = processor.process message

        expect(message_response.text).to eq 'fucking the bus'
      end
    end

    context 'when message contains multiple triggers' do
      let(:text) { 'the fucking bug hit the fucking car' }

      it 'does not respond' do
        message_response = processor.process message

        expect(message_response).to be_nil
      end
    end

    context 'when message does not contain the message' do
      let(:text) { 'the space-time continuum' }

      it 'returns nil' do
        message_response = processor.process message

        expect(message_response).to be_nil
      end
    end
  end
end
