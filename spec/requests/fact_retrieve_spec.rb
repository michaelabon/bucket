require 'rails_helper'

describe 'Triggering factoids' do

  context 'a matching trigger' do
    before do
      create(:fact, trigger: 'alpha', result: 'bravo')
    end

    it 'responds with 200 OK' do
      post '/messages', text: 'alpha', token: slack_token

      expect(response.status).to eq 200
    end

    it 'responds with the matching factoid' do
      post '/messages', text: 'alpha', token: slack_token

      expect(json['text']).to eq 'bravo'
    end
  end

  context 'no matching trigger' do
    it 'responds with 200 OK' do
      post '/messages', text: 'alpha', token: slack_token

      expect(response.status).to eq 200
    end

    it 'responds with an empty body' do
      post '/messages', text: 'alpha', token: slack_token

      expect(response.body).to eq ' '
    end
  end
end
