require 'rails_helper'

describe Bucket::Processors::SilenceDeactivate do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:message) do
      Message.new(text: text, addressed: addressed, user_name: 'MMM')
    end

    context 'when addressed' do
      let(:addressed) { true }

      shared_examples_for :a_correct_trigger do
        it 'lets everyone know it is unmuzzled' do
          message_response = processor.process(message)

          expect(message_response.text).to eq 'But MMM, I am already here.'
        end

        it 'returns a MessageReponse' do
          expect(processor.process(message)).to be_a MessageResponse
        end
      end

      it_behaves_like :a_correct_trigger do
        let(:text) { 'unshut up' }
      end

      it_behaves_like :a_correct_trigger do
        let(:text) { 'come back' }
      end

      context 'with an incorrect trigger' do
        let(:text) { 'unshut up please' }

        it 'does nothing' do
          expect(processor.process(message)).to eq nil
        end
      end
    end

    context 'when not addressed' do
      let(:addressed) { false }
      let(:text) { 'unshut up' }

      it 'returns nil' do
        expect(processor.process(message)).to eq nil
      end
    end
  end
end
