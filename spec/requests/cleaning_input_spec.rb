require 'rails_helper'

describe 'Cleaning input' do
  context 'extra spaces' do
    before do
      create(:fact, trigger: 'hello world', result: 'goodbye moon')
    end

    it 'strips and collapses spaces' do
      post '/messages', text: "\thello    world   ", token: slack_triggers_token

      expect(json['text']).to eq 'goodbye moon'
    end
  end

  context 'trailing punctuation' do
    before do
      create(:fact, trigger: 'hi! hi! hello', result: 'aloha')
    end

    it 'strips trailing punctuation' do
      post '/messages', text: 'hi! hi! hello!', token: slack_triggers_token

      expect(json['text']).to eq 'aloha'
    end
  end
end
