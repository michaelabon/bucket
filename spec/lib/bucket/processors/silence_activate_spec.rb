require 'rails_helper'

describe Bucket::Processors::SilenceActivate do
  let(:muzzle) { double(:muzzle) }
  let(:processor) { described_class.new(muzzle) }

  describe '#process' do
    let(:message) do
      Message.new(text: text, addressed: addressed, user_name: 'M2K')
    end

    context 'when addressed' do
      let(:addressed) { true }

      before do
        allow(muzzle).to receive(:clasp)
      end

      shared_examples_for :a_correct_trigger_when_silenced do
        it 'acknowledges the response' do
          message_response = processor.process(message)

          expect(message_response.text).to eq 'Okay, M2K. Be back in a bit.'
        end

        it 'returns a MessageReponse' do
          expect(processor.process(message)).to be_a MessageResponse
        end

        it "temporarily clasps bucket's muzzle" do
          processor.process(message)
          expect(muzzle).to have_received(:clasp)
        end
      end

      it_behaves_like :a_correct_trigger_when_silenced do
        let(:text) { 'go away' }
      end

      it_behaves_like :a_correct_trigger_when_silenced do
        let(:text) { 'shut up' }
      end

      context 'with an incorrect trigger' do
        let(:text) { 'shut up please' }

        it 'does nothing' do
          expect(processor.process(message)).to eq nil
        end
      end
    end

    context 'when not addressed' do
      let(:addressed) { false }
      let(:text) { 'shut up' }

      it 'returns nil' do
        expect(processor.process(message)).to eq nil
      end
    end
  end
end
