require 'rails_helper'

RSpec.describe "Giving an item from Bucket's inventory" do
  before do
    create(:fact, trigger: 'give me something', result: 'Take $giveitem')
  end

  context 'when Bucket has an item' do
    before do
      create(:item, what: 'an apple')
      create(:item, what: 'an orange')
    end

    it 'gives an item to the speaker' do
      slack_post text: 'give me something'

      expect(text).to eq('Take an apple').or eq('Take an orange')

      case text
      when 'Take an apple'
        slack_post text: 'give me something'
        expect(text).to eq 'Take an orange'
      when 'Take an orange'
        slack_post text: 'give me something'
        expect(text).to eq 'Take an apple'
      end
    end
  end

  context 'when Bucket has no items' do
    before do
      create(:item, what: 'an orange')
    end

    it 'gives bananas to the speaker' do
      slack_post text: 'give me something'

      expect(text).to eq('Take an orange')

      slack_post text: 'give me something'

      expect(text).to eq 'Take bananas'
    end
  end
end
