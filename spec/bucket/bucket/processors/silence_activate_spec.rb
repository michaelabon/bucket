require 'rails_helper'

describe Bucket::Processors::SilenceActivate do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:message) do
      Message.new(text:, addressed:, user_name: 'M2K')
    end

    context 'when addressed' do
      let(:addressed) { true }

      shared_examples_for 'a correct trigger' do
        it 'acknowledges the response' do
          message_response = processor.process(message)

          expect(message_response.text).to eq 'Okay, M2K. Be back in a bit.'
        end

        it 'returns a MessageReponse' do
          expect(processor.process(message)).to be_a MessageResponse
        end

        it 'creates a SilenceRequest that expires in the future' do
          expect { processor.process(message) }
            .to change(SilenceRequest, :count).from(0).to(1)

          silence_request = SilenceRequest.first
          expect(silence_request.requester).to eq 'M2K'
          expect(silence_request.silence_until).to be > Time.zone.now
        end
      end

      it_behaves_like 'a correct trigger' do
        let(:text) { 'go away' }
      end

      it_behaves_like 'a correct trigger' do
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

      it 'does not create a SilenceRequest' do
        expect { processor.process(message) }
          .not_to change(SilenceRequest, :count)
      end

      it 'returns nil' do
        expect(processor.process(message)).to eq nil
      end
    end
  end
end
