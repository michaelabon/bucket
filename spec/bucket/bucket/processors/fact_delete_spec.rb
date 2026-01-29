require 'rails_helper'

describe Bucket::Processors::FactDelete do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:message) do
      Message.new(
        text:,
        user_name:,
        addressed:,
      )
    end
    let(:user_name) { 'M2K' }
    let(:trigger) { 'this is the matching trigger' }
    let(:text) { "delete #{trigger}" }

    context 'when Bucket was addressed by the speaker' do
      let(:addressed) { true }

      context 'and matching facts exist' do
        before do
          create(:fact, trigger:, result: 'a')
          create(:fact, trigger:, result: 'b')
          create(:fact, trigger: 'other trigger', result: 'is not deleted')
        end

        it 'deletes all facts that match that trigger' do
          matching_facts = Fact.where(trigger:)
          expect(matching_facts.count).to eq 2
          expect(Fact.count).to eq 3

          processor.process(message)

          matching_facts = Fact.where(trigger:)
          expect(matching_facts.count).to eq 0
          expect(Fact.count).to eq 1
        end

        it 'acknowledges the request' do
          result = processor.process(message)

          expect(result.text).to eq(
            "OK, #{user_name}. I have deleted #{trigger}.",
          )
        end
      end

      context 'when no matching facts exist' do
        before do
          create(:fact, trigger: 'other trigger', result: 'is not deleted')
        end

        it 'does not delete any facts' do
          expect { processor.process(message) }.not_to change(Fact, :count)
        end

        it 'alerts the speaker of their mistake' do
          result = processor.process(message)

          expect(result.text).to eq(
            "I don't know what you're talking about, #{user_name}.",
          )
        end
      end
    end

    context 'when Bucket was not addressed' do
      let(:addressed) { false }

      it 'does not delete anything' do
        expect { processor.process(message) }.not_to change(Fact, :count)
      end

      it 'does not respond' do
        result = processor.process(message)

        expect(result).to be_nil
      end
    end
  end
end
