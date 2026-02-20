require 'rails_helper'

RSpec.describe Bucket::Processors::ForgetNoun do
  let(:processor) { described_class.new }

  describe '#process' do
    context 'when addressed' do
      let(:addressed) { true }

      context 'when the noun is known' do
        before do
          Noun.create!(
            what: 'banana',
            placed_by: 'M2K',
          )
        end

        context 'when the triggers are valid' do
          [
            'forget value $noun banana',
            'forget value banana $noun',
            'delete value $noun banana',
            'delete value banana $noun',
            'remove value $noun banana',
            'remove value banana $noun',
            'forget value $noun from banana',
            'forget value banana from $noun',
          ].each do |valid_trigger|
            it "works for the trigger '#{valid_trigger}'" do
              message = Message.new(
                text: valid_trigger,
                addressed:,
              )

              message_response = processor.process(message)

              expect(message_response).not_to be_nil
              expect(message_response.text).to eql(
                "Okay, $who, 'banana' is no longer a noun.",
              )
              expect(message_response.verb).to eql '<reply>'
            end
          end
        end

        context 'when the triggers are invalid' do
          it 'returns nil' do
            message = Message.new(
              text: 'forget value $noun',
              addressed:,
            )

            expect(processor.process(message)).to be_nil
          end
        end
      end

      context 'when the noun is not known' do
        it 'acknowledges the user’s mistake' do
          message = Message.new(
            text: 'forget value $noun banana',
            addressed:,
          )

          message_response = processor.process(message)

          expect(message_response).not_to be_nil
          expect(message_response.text).to eql(
            "I'm sorry, $who, but 'banana' is not a noun that I know of.",
          )
          expect(message_response.verb).to eql '<reply>'
        end
      end
    end

    context 'when not addressed' do
      let(:addressed) { false }

      it 'returns nil' do
        message = Message.new(
          text: 'forget value $noun banana',
          addressed:,
        )

        expect(processor.process(message)).to be_nil
      end
    end
  end
end
