require 'rails_helper'

describe Message do
  let(:message) { Message.new }

  describe 'validations' do
    it 'validates the Slack token exists' do
      expect(message).to validate_presence_of(:token)
    end

    it 'validates the Slack token is as expected' do
      expect(message).to ensure_inclusion_of(:token).
        in_array([Rails.application.secrets[:slack_token]])
    end
  end
end
