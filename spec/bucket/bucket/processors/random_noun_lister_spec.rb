require 'spec_helper'

RSpec.describe Bucket::Processors::RandomNounLister do
  let(:processor) { described_class.new }

  describe '#process' do
    before do
      create(:noun, what: 'apple')
      create(:noun, what: 'cherry')
      create(:noun, what: 'banana')
    end

    shared_examples 'list nouns' do |message_text|
      it "lists all of the nouns when asked '#{message_text}'" do
        message = Message.new(addressed: true, text: message_text)

        message_response = processor.process(message)
        expect(message_response).not_to be_nil
        expect(message_response.text).to eql '\$noun: apple, banana, and cherry'
      end
    end

    context 'when addressed' do
      context 'when the trigger is valid' do
        [
          'list values $noun',
          'list values for $noun',
          'list values of $noun',
          'list the values for $noun',
          'list the values of $noun',
          'what are the values of $noun',
          'what are the values for $noun',
        ].each do |valid_trigger|
          it_behaves_like 'list nouns', valid_trigger
        end
      end

      context 'when the trigger is invalid' do
        it 'returns nil' do
          message = Message.new(addressed: true, text: 'give me the $nouns')

          expect(processor.process(message)).to be_nil
        end
      end
    end

    context 'when not addressed' do
      it 'returns nil' do
        message = Message.new(text: 'list values $noun')

        expect(processor.process(message)).to be_nil
      end
    end
  end
end
