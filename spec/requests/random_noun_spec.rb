require 'rails_helper'

describe 'Using $noun in a fact' do
  context 'when triggering a fact with $noun in its reply' do
    before do
      create(:fact, trigger: 'im hungry', result: 'Have a $noun')
    end

    it 'replaces it with a random noun' do
      slack_post text: "I'm hungry"

      expect(text).to match(/Have a (?:potato|sword)/)
    end
  end
end
