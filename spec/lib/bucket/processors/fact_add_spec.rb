require 'rails_helper'

describe Bucket::Processors::FactAdd do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:message) do
      Message.new(
        text: text,
        user_name: 'M2K',
        addressed: addressed
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

        context 'the fact uses `<verb>`' do
          let(:text) { 'The villain <sings> mellifluously' }

          it 'adds the fact' do
            processor.process(message)

            fact = Fact.find_by(trigger: 'The villain')
            expect(fact.result).to eq 'mellifluously'
            expect(fact.verb).to eq 'sings'
          end
        end

        context 'the fact uses `is` and `<verb>`' do
          let(:text) { 'less is more <reply> more is less' }

          it 'prefers the angle brackets' do
            processor.process(message)

            fact = Fact.find_by(trigger: 'less is more')
            expect(fact.result).to eq 'more is less'
            expect(fact.verb).to eq '<reply>'
          end
        end

        context 'the fact uses `are` and `<verb>`' do
          let(:text) do
            'you are broken <reply> I am a product of my environment'
          end

          it 'prefers the angle brackets' do
            processor.process(message)

            fact = Fact.find_by(trigger: 'you are broken')
            expect(fact.result).to eq 'I am a product of my environment'
            expect(fact.verb).to eq '<reply>'
          end
        end

        context 'the fact uses multiple angle brackets' do
          let(:text) { 'the first <alpha> the second <bravo> the third' }

          it 'only uses the first one' do
            processor.process(message)

            fact = Fact.find_by(trigger: 'the first')
            expect(fact.result).to eq 'the second <bravo> the third'
            expect(fact.verb).to eq 'alpha'
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
