require 'rails_helper'

describe 'Triggering factoids' do

  before do
    create(:fact, trigger: 'alpha', result: 'bravo')
  end

  context 'a matching trigger' do
    it 'responds with 200 OK' do
      slack_post text: 'alpha'

      expect(response.status).to eq 200
    end

    it 'responds with the matching factoid' do
      slack_post text: 'alpha'

      expect(text).to eq 'bravo'
    end
  end

  context 'no matching trigger' do
    it 'responds with 200 OK' do
      slack_post text: 'alphabet'

      expect(response.status).to eq 200
    end

    it 'responds with an empty json body' do
      slack_post text: 'alphabet'

      expect(response.body).to eq '{}'
    end
  end
end
