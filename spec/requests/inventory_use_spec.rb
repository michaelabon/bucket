require 'rails_helper'

describe "Using an item from Bucket's inventory" do
  before do
    create(:fact, trigger: 'be helpful', result: 'I have $item and $item')
  end

  context 'when Bucket has an item' do
    before do
      create(:item, what: 'apples')
      create(:item, what: 'bananas')
    end

    it "replaces all instances of `$item' with an item" do
      slack_post text: 'be helpful'

      expect(text)
        .to eq('I have apples and bananas')
        .or eq('I have bananas and apples')
    end
  end
end
