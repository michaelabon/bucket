require 'rails_helper'

describe 'Cleaning input' do
  context 'extra spaces' do
    before do
      create(:fact, trigger: 'hello world', result: 'goodbye moon')
    end

    it 'strips and collapses spaces' do
      slack_post text: "\thello    world   "

      expect(json['text']).to eq 'goodbye moon'
    end
  end
end
