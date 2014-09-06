require 'rails_helper'

describe Bucket::Postprocessors::Inventory do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:ordered_items) { double(:ordered_items) }
    let(:items) { double(:items) }
    let(:item_list) { 'a, b, and c' }

    before do
      allow(Item).to receive(:order).with(:created_at) { ordered_items }
      allow(ordered_items).to receive(:pluck).with(:what) { items }
      allow(Bucket::Helpers::MakeList).to receive(:make_list).
        with(items) { item_list }
    end

    context 'message_response contains $inventory' do
      let(:message_response) { 'I have $inventory' }

      it 'converts the message' do
        expect(processor.process(message_response)).to eq 'I have a, b, and c'
      end
    end

    context 'message_response does not contain $inventory' do
      let(:message_response) { 'non-trigger' }

      it 'does not convert the message' do
        expect(processor.process(message_response)).to eq 'non-trigger'
      end
    end
  end
end
