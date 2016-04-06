require 'spec_helper'

describe Bucket::Postprocessors::ReplaceWho do
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

  context 'when the message response does not contain `$who`' do
    it 'does not change the response text' do
      message_response = MessageResponse.new(
        text: 'This only contains the word who'
      )
      postprocessor.process(message_response)
      expect(message_response.text).to eq 'This only contains the word who'
    end
  end

  context 'when the message response contains a single `$who`' do
    it 'replaces the $who with the user name of the speaker' do
      message_response = MessageResponse.new(
        text: 'This contains one and only one $who',
        user_name: 'Bob'
      )
      postprocessor.process(message_response)
      expect(message_response.text).to eq 'This contains one and only one Bob'
    end
  end

  context 'when the message response contains multiple `$who`s' do
    it 'replaces all instances of $who with the user name of the speaker' do
      message_response = MessageResponse.new(
        text: 'Who are you? $who, $who, $who, $who.',
        user_name: 'Ice Cube'
      )
      postprocessor.process(message_response)
      expect(message_response.text).to eq(
        'Who are you? Ice Cube, Ice Cube, Ice Cube, Ice Cube.'
      )
    end
  end
end
