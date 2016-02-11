require 'rails_helper'

describe Bucket::Postprocessors::ReplaceItem do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:message_response) { MessageResponse.new(text: text) }

    context "message_response contains one or more instances of `$item'" do
      let(:text) { 'I have $item and $item' }

      context "when there is a unique item for each `$item'" do
        it 'converts the message' do
          create(:item, what: 'a thing')
          create(:item, what: 'a book')

          processor.process(message_response)

          expect(message_response.text)
            .to eq('I have a thing and a book')
            .or eq('I have a book and a thing')
        end
      end

      context "when there are not enough unique items for each `$item'" do
        it "replaces the missing items with `bananas'" do
          create(:item, what: 'a thing')

          processor.process(message_response)

          expect(message_response.text).to eq 'I have a thing and bananas'
        end
      end

      context 'when there are no items' do
        it "replaces the missing items with `bananas'" do
          processor.process(message_response)

          expect(message_response.text).to eq 'I have bananas and bananas'
        end
      end
    end

    context "message_response does not contain `$item'" do
      let(:text) { 'missing trigger' }

      it 'does not convert the message' do
        create(:item, what: 'a thing')

        processor.process(message_response)

        expect(message_response.text).to eq 'missing trigger'
      end
    end

    context 'message_response is empty' do
      let(:message_response) { nil }

      it 'still works' do
        create(:item, what: 'a thing')

        processor.process(message_response)

        expect(message_response).to eq nil
      end
    end
  end
end
