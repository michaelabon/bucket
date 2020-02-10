require 'rails_helper'

describe Bucket::Processors::LearnNoun do
  let(:processor) { described_class.new }

  describe '#process' do
    context 'when addressed' do
      let(:addressed) { true }

      context 'when the triggers are valid' do
        [
          'add value $noun banana',
          'add value banana $noun',
          'add banana to $noun',
        ].each do |valid_trigger|
          it "works for the trigger '#{valid_trigger}'" do
            message = Message.new(
              text: valid_trigger,
              addressed: addressed
            )

            message_response = processor.process(message)

            expect(message_response).to_not be_nil
            expect(message_response.text).to eql(
              "Okay, $who, 'banana' is now a noun."
            )
            expect(message_response.verb).to eql '<reply>'
          end
        end
      end

      context "when it doesn't match the triggers" do
        it 'returns nil' do
          message = Message.new(
            text: 'add value $noun',
            addressed: addressed
          )

          expect(processor.process(message)).to be_nil
        end
      end
    end

    context 'when not addressed' do
      let(:addressed) { false }

      it 'returns nil' do
        message = Message.new(
          text: 'add value $noun banana',
          addressed: addressed
        )

        expect(processor.process(message)).to be_nil
      end
    end
  end
end
