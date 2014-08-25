require 'rails_helper'

describe 'Triggering factoids' do

  before do
    Fact.create(trigger: 'alpha', fact: 'bravo')
  end

  context 'a matching trigger' do
    it 'responds with the matching factoid' do
      post '/messages/receive', body: { text: 'alpha' }

      expect(json['text']).to eq 'bravo'
    end
  end
end
