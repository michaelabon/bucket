require 'rails_helper'

describe Bucket::Processors::InventoryList do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:message) { Message.new(text: text, addressed: addressed) }

    context 'Bucket was addressed' do
      let(:addressed) { true }

      context 'trigger is valid' do
        [
          'inv',
          'inventory',
          'items',
          'list items',
          'what are you carrying',
          'what are you holding',
        ].each do |trigger|
          let(:text) { trigger }

          it "responds to “#{trigger}”" do
            message_response = processor.process(message)

            expect(message_response).to include '$inventory'
          end
        end
      end

      context 'trigger is invalid' do
        let(:text) { 'Non-trigger' }

        it "doesn't respond" do
          puts text
          message_response = processor.process(message)

          expect(message_response).not_to be
        end
      end
    end

  end
end
