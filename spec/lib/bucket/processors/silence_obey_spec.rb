require 'rails_helper'

describe Bucket::Processors::SilenceObey do
  let(:muzzle) { double(:muzzle) }
  let(:processor) { described_class.new(muzzle) }

  describe '#process' do
    let(:message) do
      Message.new(text: 'alpha', addressed: true, user_name: 'M2K')
    end

    before do
      create(:fact, trigger: 'alpha', result: 'bravo', verb: '<reply>')
    end

    context 'when muzzled' do
      before do
        allow(muzzle).to receive(:clasped?).and_return(true)
      end

      it 'returns an empty MessageResponse to stop further processing' do
        message_response = processor.process(message)

        expect(message_response).to be_a MessageResponse
        expect(message_response.text).to eq nil
      end
    end

    context 'when not muzzled' do
      before do
        allow(muzzle).to receive(:clasped?).and_return(false)
      end
      it 'returns nil to allow further processing' do
        expect(processor.process(message)).to eq nil
      end
    end
  end
end
