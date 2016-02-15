require 'spec_helper'

describe Bucket::Processors::IgnoreBots do
  let(:processor) { described_class.new }

  # Ignored user names are in config/secrets.yml
  context "when the speaker's name is on the list" do
    it 'returns an empty MessageResponse' do
      message_response = processor.process(Message.new(user_name: 'slackbot'))

      expect(message_response.text).to eq ''

      message_response = processor.process(Message.new(user_name: 'testbot'))

      expect(message_response.text).to eq ''
    end
  end

  context "when the speaker's name is not on the list" do
    it 'does not respond' do
      message_response = processor.process(Message.new(user_name: 'mike'))

      expect(message_response).to be_nil
    end
  end
end
