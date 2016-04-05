require 'spec_helper'

describe Bucket::Processors::MoveAssHyphens do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:message) do
      Message.new(text: text)
    end

    context 'when message contains `<word>-ass <word>`' do
      let(:text) { 'a big-ass car drove by' }

      it 'repeats the message but moves the hyphen' do
        message_response = processor.process message

        expect(message_response.text).to eq 'a big ass-car drove by'
      end
    end

    context 'when message contains multiple triggers' do
      let(:text) { 'large-ass snake on a big-ass plane' }

      it 'repeats the message but moves all the appropriate hyphens' do
        message_response = processor.process message

        expect(message_response.text).to eq 'large ass-snake on a big ass-plane'
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
