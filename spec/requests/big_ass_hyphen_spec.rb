require 'rails_helper'

RSpec.describe 'Moving a big ass-hyphen' do
  context 'when given a sentence with <word>-ass <word>' do
    it 'moves the hyphen one word over' do
      slack_post text: 'Whoa! That is a big-ass car'

      expect(text).to eq 'Whoa! That is a big ass-car'
    end
  end
end
