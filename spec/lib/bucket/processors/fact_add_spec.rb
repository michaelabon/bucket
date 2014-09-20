require 'rails_helper'

describe Bucket::Processors::FactAdd do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:message) do
      Message.new(
        text: text,
        user_name: 'M2K',
        addressed: addressed,
      )
    end
    let(:text) { 'X <action> Y' }

    context 'Bucket was addressed by the speaker' do
      let(:addressed) { true }

      it 'acknowledges the speaker’s command' do
        result = processor.process(message)

        expect(result.text).to eq 'OK, M2K'
      end

      describe 'de-duplicates facts' do

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

      describe 'verb types' do
        context 'the fact uses `is`' do
          let(:text) { 'alpha is bravo' }

          it 'adds the fact' do
            processor.process(message)

            fact = Fact.find_by(trigger: 'alpha')
            expect(fact.result).to eq 'bravo'
            expect(fact.verb).to eq 'is'
          end
        end

        context 'the fact uses `are`' do
          let(:text) { 'cheetahs are delicious' }

          it 'adds the fact' do
            processor.process(message)

            fact = Fact.find_by(trigger: 'cheetahs')
            expect(fact.result).to eq 'delicious'
            expect(fact.verb).to eq 'are'
          end
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
