require 'rails_helper'

describe 'Listing inventory' do
  before do
    create(:item, what: 'an apple')
    create(:item, what: 'true love')
    create(:item, what: 'magnets')
  end

  context 'when addressed' do
    it 'responds with a commafied list of items' do
      slack_post text: 'Bucket, what are you carrying?'

      expect(text).to include 'an apple, true love, and magnets'
    end
  end

  context 'when not addressed' do
    it 'does not respond' do
      slack_post text: 'inv'

      expect(response.body).to eq '{}'
    end
  end
end
