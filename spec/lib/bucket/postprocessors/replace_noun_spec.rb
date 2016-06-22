require 'spec_helper'

describe Bucket::Postprocessors::ReplaceNoun do
  let(:postprocessor) { described_class.new }

  context 'when the message response is blank' do
    it 'does nothing' do
      message_response = nil
      postprocessor.process(message_response)
      expect(message_response).to be_nil
    end
  end

  context 'when the message response’s text is nil' do
    it 'does nothing' do
      message_response = MessageResponse.new(text: nil)
      postprocessor.process(message_response)
      expect(message_response.text).to be_nil
    end
  end

  context 'when the message response does not contain `$noun`' do
    it 'does not change the response text' do
      message_response = MessageResponse.new(
        text: 'This only contains the word noun'
      )
      postprocessor.process(message_response)
      expect(message_response.text).to eq 'This only contains the word noun'
    end
  end

  context 'when the message response contains a single `$noun`' do
    it 'replaces the $noun with a random noun' do
      message_response = MessageResponse.new(
        text: 'This contains one and only one $noun'
      )
      postprocessor.process(message_response)
      expect(message_response.text)
        .to match(/\AThis contains one and only one (?:potato|sword)\z/)
    end
  end

  context 'when the message response contains multiple `$noun`s' do
    it 'replaces all instances of $noun with random nouns' do
      message_response = MessageResponse.new(
        text: 'I love $noun and $noun'
      )
      postprocessor.process(message_response)
      expect(message_response.text)
        .to match(/\AI love (?:potato|sword) and (?:potato|sword)\z/)
    end
  end
end
