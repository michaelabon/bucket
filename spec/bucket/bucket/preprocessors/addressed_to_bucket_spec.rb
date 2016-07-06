require 'spec_helper'

describe Bucket::Preprocessors::AddressedToBucket do
  let(:processor) { described_class.new }

  # TODO: shared_examples_for or behaves_like

  describe '#process' do
    let(:message) { Message.new(text: text) }

    context 'Bucket was addressed' do
      shared_examples_for :an_addressed_message do
        it 'sets message’s addressed to true' do
          processor.process(message)

          expect(message).to be_addressed
        end

        it 'cleans up the message’s text' do
          processor.process(message)

          expect(message.text).to eq '"X" is "Y"'
        end
      end

      context 'starts with "Bucket, "' do
        it_behaves_like :an_addressed_message do
          let(:text) { 'Bucket,   "X" is "Y"' }
        end
      end

      context 'starts with "Bucket: "' do
        it_behaves_like :an_addressed_message do
          let(:text) { 'Bucket:   "X" is "Y"' }
        end
      end

      context 'starts with "@Bucket "' do
        it_behaves_like :an_addressed_message do
          let(:text) { '@Bucket   "X" is "Y"' }
        end
      end

      context 'ends with ", Bucket"' do
        it_behaves_like :an_addressed_message do
          let(:text) { '"X" is "Y", Bucket' }
        end
      end
    end

    shared_examples_for :an_unaddressed_message do
      it 'sets message’s addressed to false' do
        processor.process(message)

        expect(message).not_to be_addressed
      end

      it 'does not modify the message’s text' do
        processor.process(message)

        expect(message.text).to eq text
      end
    end

    context 'when the address appears in the wrong spot' do
      it_behaves_like :an_unaddressed_message do
        let(:text) { 'I said, Bucket: Learning is fun' }
      end
    end

    context 'Bucket was not addressed' do
      it_behaves_like :an_unaddressed_message do
        let(:text) { 'Chump: "X" is "Y"' }
      end
    end
  end
end
