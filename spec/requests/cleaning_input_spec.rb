require 'rails_helper'

RSpec.describe 'Cleaning input' do
  context 'when there are extra spaces' do
    before do
      create(:fact, trigger: 'hello world', result: 'goodbye moon')
    end

    it 'strips and collapses spaces' do
      slack_post text: "\thello    world   "

      expect(text).to eq 'goodbye moon'
    end
  end
end
