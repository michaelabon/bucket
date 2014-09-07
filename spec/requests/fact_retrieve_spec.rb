require 'rails_helper'

describe 'Triggering factoids' do

  before do
    create(:fact, trigger: 'alpha', result: 'bravo')
  end

  context 'a matching trigger' do
    it 'responds with 200 OK' do
      post '/messages', text: 'alpha', token: slack_triggers_token

      expect(response.status).to eq 200
    end

    it 'responds with the matching factoid' do
      post '/messages', text: 'alpha', token: slack_triggers_token

      expect(json['text']).to eq 'bravo'
    end
  end

  context 'no matching trigger' do
    it 'responds with 200 OK' do
      post '/messages', text: 'alphabet', token: slack_triggers_token

      expect(response.status).to eq 200
    end

    it 'responds with an empty json body' do
      post '/messages', text: 'alphabet', token: slack_triggers_token

      expect(response.body).to eq '{}'
    end
  end
end
