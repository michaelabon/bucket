require 'rails_helper'

describe 'Triggering factoids' do
  before do
    create(:fact, trigger: 'alpha', result: 'bravo')
  end

  context 'when there is a matching trigger' do
    it 'responds with 200 OK' do
      slack_post text: 'alpha'

      expect(response).to have_http_status :ok
    end

    it 'responds with the matching factoid' do
      slack_post text: 'alpha'

      expect(text).to eq 'bravo'
    end
  end

  context 'when there is no matching trigger' do
    it 'responds with 200 OK' do
      slack_post text: 'alphabet'

      expect(response).to have_http_status :ok
    end

    it 'responds with an empty json body' do
      slack_post text: 'alphabet'

      expect(response.body).to eq '{}'
    end
  end
end
