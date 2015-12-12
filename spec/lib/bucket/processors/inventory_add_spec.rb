require 'rails_helper'

describe Bucket::Processors::InventoryAdd do
  let(:processor) { described_class.new }

  describe '#process' do
    shared_examples :common_triggers do
      [
        'gives Bucket fuzzy kittens',
        'gives fuzzy kittens to Bucket',
        'hands Bucket fuzzy kittens',
        'hands Bucket fuzzy kittens!',
        'hands Bucket fuzzy kittens?',
        'hands Bucket fuzzy kittens.',
        'hands Bucket fuzzy kittens . . . ',
        'hands fuzzy kittens to Bucket',
        'puts fuzzy kittens in Bucket',
        'puts fuzzy kittens in the Bucket',
      ].each do |trigger|
        it "adds the item for `#{trigger}`" do
          message = Message.new(
            text: trigger,
            user_name: 'M2K',
            addressed: addressed,
          )

          message_response = processor.process(message)

          expect(message_response).not_to be_nil
          expect(message_response.text).to eq 'is now carrying fuzzy kittens'
          expect(message_response.verb).to eq '<action>'
        end
      end

      [
        'gives Bucket his fuzzy kittens',
        'gives her fuzzy kittens to Bucket',
        'hands Bucket their fuzzy kittens',
        "gives Bucket M2K's fuzzy kittens",
        'gives Bucket his fuzzy kittens!',
        'gives her fuzzy kittens to Bucket.',
        'hands Bucket their fuzzy kittens?',
        "gives Bucket M2K's fuzzy kittens ? ",
      ].each do |trigger|
        it "adds the item for `#{trigger}`" do
          message = Message.new(
            text: trigger,
            user_name: 'M2K',
            addressed: addressed,
          )

          message_response = processor.process(message)

          expect(message_response).not_to be_nil
          expect(message_response.text)
            .to eq "is now carrying M2K's fuzzy kittens"
          expect(message_response.verb).to eq '<action>'
        end
      end
    end

    context 'Bucket was addressed by the speaker' do
      let(:addressed) { true }

      context 'when the trigger matches' do
        include_examples :common_triggers

        describe 'addressed-only triggers' do
          {
            'take this fuzzy kitten' => 'this fuzzy kitten',
            'take these fuzzy kittens' => 'these fuzzy kittens',
            'have a fuzzy kitten' => 'a fuzzy kitten',
            'have an exploding kitten' => 'an exploding kitten',
          }.each do |trigger, stored_item|
            let(:text) { k }

            it "adds the item for `#{trigger}`" do
              message = Message.new(
                text: trigger,
                user_name: 'M2K',
                addressed: addressed,
              )
              message_response = processor.process(message)

              expect(message_response).not_to be_nil
              expect(message_response.text)
                .to eq "is now carrying #{stored_item}"
              expect(message_response.verb).to eq '<action>'
            end
          end
        end
      end

      context 'when the trigger does not match' do
        [
          'have fun',
          'take this',
          'gives something',

        ].each do |trigger|
          it 'does not add the item for `#{trigger}`' do
            message = Message.new(
              text: trigger,
              user_name: 'M2K',
              addressed: addressed,
            )
            expect(processor.process(message)).to eq nil
          end
        end
      end
    end

    context 'Bucket was not addressed by the speaker' do
      let(:addressed) { false }

      include_examples :common_triggers
    end
  end
end
