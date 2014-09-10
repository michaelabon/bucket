require 'rails_helper'

describe Bucket::Processors::FactAdd do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:message) do
      Message.new(
        text: '"X" <action> "Y"',
        user_name: 'M2K',
        addressed: addressed,
      )
    end

    context 'Bucket was addressed by the speaker' do
      let(:addressed) { true }

      it 'acknowledges the speaker’s command' do
        result = processor.process(message)

        expect(result.text).to eq 'OK, M2K'
      end

      context 'the fact was new' do
        it 'adds the fact' do
          processor.process(message)

          fact = Fact.find_by(trigger: 'X')
          expect(fact.result).to eq 'Y'
          expect(fact.verb).to eq '<action>'
        end
      end

      context 'the fact was old' do
        before do
          create(:fact, trigger: 'X', result: 'Y', verb: '<action>')
        end

        it 'does not duplicate the fact' do
          expect { processor.process(message) }.not_to change { Fact.count }
        end
      end
    end

    context 'Bucket was not addressed by the speaker' do
      let(:addressed) { false }

      it 'does nothing' do
        result = processor.process(message)

        expect(result).to eq nil
      end
    end
  end
end
