require 'rails_helper'

RSpec.describe 'replacing $who in a message response' do
  context 'when the message response contains `$who` in it' do
    before do
      create(:fact, trigger: 'who am i', result: 'you are $who, $who')
    end

    it 'replaces the `$who` with the username of the speaker' do
      slack_post(text: 'Who am i?!!', user_name: 'M2K')

      expect(text).to eq('you are M2K, M2K')
    end
  end
end
