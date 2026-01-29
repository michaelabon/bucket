require 'spec_helper'

describe Bucket::Postprocessors::ReplaceInventory do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:ordered_items) { instance_double(ActiveRecord::Relation) }
    let(:items) { instance_double(Array) }
    let(:item_list) { 'a, b, and c' }
    let(:message_response) { MessageResponse.new(text:) }

    before do
      allow(Item).to receive(:order).with(:created_at) { ordered_items }
      allow(ordered_items).to receive(:pluck).with(:what) { items }
      allow(Bucket::Helpers::MakeList).to receive(:make_list)
        .with(items) { item_list }
    end

    context 'when message_response contains $inventory' do
      let(:text) { 'I have $inventory' }

      it 'converts the message' do
        processor.process(message_response)

        expect(message_response.text).to eq 'I have a, b, and c'
      end
    end

    context 'when message_response does not contain $inventory' do
      let(:text) { 'non-trigger' }

      it 'does not convert the message' do
        processor.process(message_response)

        expect(message_response.text).to eq 'non-trigger'
      end
    end

    context 'when message_response is empty' do
      let(:message_response) { nil }

      it 'still works' do
        processor.process(message_response)

        expect(message_response).to be_nil
      end
    end
  end
end
