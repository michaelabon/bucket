require 'rails_helper'

describe Bucket::Processors::SilenceObey do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:message) do
      Message.new(text: 'alpha', addressed: true, user_name: 'M2K')
    end

    before do
      create(:fact, trigger: 'alpha', result: 'bravo', verb: '<reply>')
    end

    context 'when there is a current SilenceRequest' do
      before do
        create(:silence_request)
      end

      it 'returns an empty MessageResponse to stop further processing' do
        message_response = processor.process(message)

        expect(message_response).to be_a MessageResponse
        expect(message_response.text).to eq nil
      end
    end

    context 'when there is an expired SilenceRequest' do
      before do
        create(:silence_request, silence_until: 3.days.ago)
      end

      it 'returns nil to allow further processing' do
        expect(processor.process(message)).to eq nil
      end
    end

    context 'when there are no SilenceRequests' do
      it 'returns nil to allow further processing' do
        expect(processor.process(message)).to eq nil
      end
    end
  end
end
