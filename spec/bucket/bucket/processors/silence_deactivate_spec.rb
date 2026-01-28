require 'rails_helper'

describe Bucket::Processors::SilenceDeactivate do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:message) do
      Message.new(text:, addressed:, user_name: 'MMM')
    end

    context 'when addressed' do
      let(:addressed) { true }

      shared_examples_for 'a correct trigger' do
        it 'gives the expected response' do
          message_response = processor.process(message)

          expect(message_response.text).to eq response_text
        end

        it 'returns a MessageReponse' do
          expect(processor.process(message)).to be_a MessageResponse
        end

        it 'removes any SilenceRequests' do
          processor.process(message)

          expect(SilenceRequest.count).to eq 0
        end
      end

      context 'when Bucket is silenced' do
        let(:response_text) { "I'm back, $who!" }

        before do
          SilenceRequest.create!(
            requester: 'Some lame person',
            silence_until: 3.days.from_now,
          )
        end

        it_behaves_like 'a correct trigger' do
          let(:text) { 'unshut up' }
        end

        it_behaves_like 'a correct trigger' do
          let(:text) { 'come back' }
        end

        context 'with an incorrect trigger' do
          let(:text) { 'unshut up please' }

          it 'does nothing' do
            expect(processor.process(message)).to eq nil
          end
        end
      end

      context 'when Bucket is not silenced' do
        let(:response_text) { 'But MMM, I am already here.' }

        it_behaves_like 'a correct trigger' do
          let(:text) { 'unshut up' }
        end

        it_behaves_like 'a correct trigger' do
          let(:text) { 'come back' }
        end

        context 'with an incorrect trigger' do
          let(:text) { 'unshut up please' }

          it 'does nothing' do
            expect(processor.process(message)).to eq nil
          end
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
