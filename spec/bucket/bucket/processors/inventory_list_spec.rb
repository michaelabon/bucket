require 'rails_helper'

describe Bucket::Processors::InventoryList do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:message) { Message.new(text:, addressed:) }

    context 'when Bucket was addressed' do
      let(:addressed) { true }

      shared_examples_for 'a valid trigger' do
        it 'responds to text' do
          message_response = processor.process(message)

          expect(message_response).not_to be_nil
          expect(message_response.text).to include '$inventory'
          expect(message_response.verb)
            .to eq('<reply>')
            .or eq('<action>')
        end
      end

      context 'when the trigger is valid' do
        it_behaves_like 'a valid trigger' do
          let(:text) { 'inventory' }
        end

        it_behaves_like 'a valid trigger' do
          let(:text) { 'items' }
        end

        it_behaves_like 'a valid trigger' do
          let(:text) { 'list items' }
        end

        it_behaves_like 'a valid trigger' do
          let(:text) { 'list inventory' }
        end

        it_behaves_like 'a valid trigger' do
          let(:text) { 'list your items' }
        end

        it_behaves_like 'a valid trigger' do
          let(:text) { 'list your inventory' }
        end

        it_behaves_like 'a valid trigger' do
          let(:text) { 'what are you carrying' }
        end

        it_behaves_like 'a valid trigger' do
          let(:text) { 'what are you holding' }
        end

        it_behaves_like 'a valid trigger' do
          let(:text) { 'inv' }
        end

        it_behaves_like 'a valid trigger' do
          let(:text) { 'what are your items' }
        end

        it_behaves_like 'a valid trigger' do
          let(:text) { 'what do you carry' }
        end

        it_behaves_like 'a valid trigger' do
          let(:text) { 'what do you have' }
        end
      end

      context 'when the trigger is invalid' do
        let(:text) { 'Non-trigger' }

        it 'does not respond' do
          message_response = processor.process(message)

          expect(message_response).not_to be
        end
      end
    end

    context 'when Bucket was not addressed' do
      let(:addressed) { false }
      let(:text) { 'inv' }

      it 'does not respond' do
        message_response = processor.process(message)

        expect(message_response).not_to be
      end
    end
  end
end
