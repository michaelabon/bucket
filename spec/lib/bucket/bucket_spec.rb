require 'rails_helper'

describe Bucket::Bucket do
  let(:bucket) { described_class.new(processors) }
  let(:processors) { [processor1_klass, processor2_klass] }
  let(:processor1_klass) { double(:processor1_klass, new: processor1) }
  let(:processor2_klass) { double(:processor2_klass, new: processor2) }
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
  end
end
