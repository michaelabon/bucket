require 'rails_helper'

describe "Using an item from Bucket's inventory" do
  before do
    create(:fact, trigger: 'be helpful', result: 'I have $item and $item')
  end

  context 'when Bucket has an item' do
    before do
      create(:item, what: 'apples')
      create(:item, what: 'oranges')
    end

    it "replaces all instances of `$item' with an item" do
      slack_post text: 'be helpful'

      expect(text)
        .to eq('I have apples and oranges')
        .or eq('I have oranges and apples')
    end
  end

  context 'when Bucket does not have an item' do
    it "replaces all instances of `$item' with `bananas'" do
      slack_post text: 'be helpful'

      expect(text).to eq('I have bananas and bananas')
    end
  end
end
