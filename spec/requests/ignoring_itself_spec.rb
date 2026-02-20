require 'rails_helper'

RSpec.describe 'Ignoring itself' do
  before do
    create(:fact, trigger: 'alpha', result: 'bravo', verb: '<reply>')
  end

  context 'when the speaker is a slack bot' do
    it 'does not respond' do
      slack_post text: 'alpha', user_name: 'slackbot'

      expect(response.body).to eq '{}'
    end
  end

  context 'when the speaker is a human' do
    it '(may) respond' do
      slack_post text: 'alpha', user_name: 'human'

      expect(text).to eq 'bravo'
    end
  end
end
