require 'rails_helper'

describe Bucket::Preprocessors::AddressedToBucket do
  let(:processor) { described_class.new }

  # TODO: shared_examples_for or behaves_like

  describe '#process' do
    let(:message) { Message.new(text: text) }

    context 'Bucket was addressed' do
      context 'starts with "Bucket, "' do
        let(:text) { 'Bucket,   "X" is "Y"' }

        it 'sets message’s addressed to true' do
          processor.process(message)

          expect(message).to be_addressed
        end

        it 'cleans up the message’s text' do
          processor.process(message)

          expect(message.text).to eq '"X" is "Y"'
        end
      end

      context 'starts with "Bucket: "' do
        let(:text) { 'Bucket:   "X" is "Y"' }

        it 'sets message’s addressed to true' do
          processor.process(message)

          expect(message).to be_addressed
        end

        it 'cleans up the message’s text' do
          processor.process(message)

          expect(message.text).to eq '"X" is "Y"'
        end
      end

      context 'starts with "@Bucket "' do
        let(:text) { '@Bucket   "X" is "Y"' }

        it 'sets message’s addressed to true' do
          processor.process(message)

          expect(message).to be_addressed
        end

        it 'cleans up the message’s text' do
          processor.process(message)

          expect(message.text).to eq '"X" is "Y"'
        end
      end

      context 'ends with ", Bucket"' do
        let(:text) { '"X" is "Y", Bucket' }

        it 'sets message’s addressed to true' do
          processor.process(message)

          expect(message).to be_addressed
        end

        it 'cleans up the message’s text' do
          processor.process(message)

          expect(message.text).to eq '"X" is "Y"'
        end
      end
    end

    context 'Bucket was not addressed' do
      let(:text) { 'Chump: "X" is "Y"' }

      it 'sets message’s addressed to false' do
        processor.process(message)

        expect(message).not_to be_addressed
      end

      it 'does not modify the message’s text' do
        processor.process(message)

        expect(message.text).to eq 'Chump: "X" is "Y"'
      end
    end
  end
end
