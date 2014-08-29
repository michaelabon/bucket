require 'rails_helper'

describe Bucket::Bucket do
  let(:bucket) do
    described_class.new(preprocessors: preprocessors, processors: processors)
  end
  let(:preprocessors) { [preprocessor1, preprocessor2] }
  let(:preprocessor1) { double(:preprocessor1, process: true) }
  let(:preprocessor2) { double(:preprocessor2, process: true) }
  let(:processors) { [processor1, processor2] }
  let(:processor1) { double(:processor1) }
  let(:processor2) { double(:processor2) }
  let(:message) { double(:message) }

  describe '#process' do
    describe 'processor order matters' do
      context 'first processor has a positive result' do
        before do
          allow(processor1).to receive(:process).with(message) { 'alpha' }
        end

        it 'returns the first processor’s result' do
          result = bucket.process(message)

          expect(result).to eq 'alpha'
        end

        it 'does not call the second processor' do
          expect(processor2).not_to receive(:process)

          bucket.process(message)
        end
      end

      context 'first processor has a negative result' do
        before do
          allow(processor1).to receive(:process).with(message) { nil }
          allow(processor2).to receive(:process).with(message) { 'bravo' }
        end

        it 'returns the second processor’s result' do
          result = bucket.process(message)

          expect(result).to eq 'bravo'
        end
      end
    end

    describe 'preprocessor order matters' do
      before do
        allow(processor1).to receive(:process).with(message) { nil }
        allow(processor2).to receive(:process).with(message) { nil }
      end

      it 'calls the preprocessors' do
        bucket.process(message)

        expect(preprocessor1).to have_received(:process).with(message)
        expect(preprocessor2).to have_received(:process).with(message)
      end
    end

  end
end
