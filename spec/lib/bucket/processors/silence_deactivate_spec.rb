require 'rails_helper'

describe Bucket::Processors::SilenceDeactivate do
  let(:muzzle) { spy(Muzzle::Muzzle) }
  let(:processor) { described_class.new(muzzle) }

  describe '#process' do
    let(:message) do
      Message.new(text: text, addressed: addressed, user_name: 'MMM')
    end

    context 'when addressed' do
      let(:addressed) { true }

      context 'with an incorrect trigger' do
        let(:text) { 'unshut up please' }

        it 'does nothing' do
          expect(processor.process(message)).to eq nil
        end
      end

      context 'when silenced' do
        before do
          allow(muzzle).to receive(:clasped?).and_return(true)
          allow(muzzle).to receive(:unclasp)
        end

        shared_examples_for :a_correct_trigger_when_silenced do
          it 'breaks the clasp’s confinements' do
            processor.process(message)
            expect(muzzle).to have_received(:unclasp)
          end

          it 'confirms the command' do
            reply = processor.process(message).text
            expect(reply).to eq 'Thanks for inviting me back, MMM!'
          end

          it 'returns a MessageReponse' do
            expect(processor.process(message)).to be_a MessageResponse
          end
        end

        it_behaves_like :a_correct_trigger_when_silenced do
          let(:text) { 'unshut up' }
        end

        it_behaves_like :a_correct_trigger_when_silenced do
          let(:text) { 'come back' }
        end
      end

      context 'when not silenced' do
        before do
          allow(muzzle).to receive(:clasped?).and_return(false)
        end

        shared_examples_for :a_correct_trigger_when_not_silenced do
          it 'lets everyone know it is unmuzzled' do
            message_response = processor.process(message)
            expect(message_response.text).to eq 'But MMM, I am already here.'
          end

          it 'returns a MessageReponse' do
            expect(processor.process(message)).to be_a MessageResponse
          end
        end

        it_behaves_like :a_correct_trigger_when_not_silenced do
          let(:text) { 'unshut up' }
        end

        it_behaves_like :a_correct_trigger_when_not_silenced do
          let(:text) { 'come back' }
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
