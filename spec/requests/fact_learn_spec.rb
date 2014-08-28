require 'rails_helper'

describe 'Learning factoids' do

  context 'the factoid is new' do
    it 'learns the factoid' do
      post '/messages', text: '"X" is "Y"', token: slack_token, user_name: 'M2K'

      expect(json['text']).to eq 'OK, M2K'

      post '/messages', text: 'X', token: slack_token

      expect(json['text']).to eq 'Y'
    end
  end

  context 'the trigger is old but the result is new' do
    before do
      create(:fact, trigger: 'X', result: 'Y')
    end

    it 'learns the factoid' do
      post '/messages', text: '"X" is "Z"', token: slack_token, user_name: 'M2K'

      expect(json['text']).to eq 'OK, M2K'

      # QUESTION: How to test random responses?
      expect(Fact.find_by(trigger: 'X', result: 'Z')).to be
    end
  end

  context 'the factoid already exists' do
    before do
      create(:fact, trigger: 'X', result: 'Y')
    end

    it 'pretends to learn the factoid' do
      post '/messages', text: '"X" is "Y"', token: slack_token, user_name: 'M2K'

      expect(json['text']).to eq 'OK, M2K'
      expect(Fact.count).to eq 1
    end
  end
end
