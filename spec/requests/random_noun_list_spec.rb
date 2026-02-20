require 'rails_helper'

RSpec.describe 'listing the values for $noun' do
  context 'when Bucket is addressed' do
    before do
      create(:noun, what: 'coffee')
      create(:noun, what: 'seashell')
      create(:noun, what: 'peanut')
    end

    shared_examples 'list the values for $noun' do |input|
      it "responds to '#{input}'" do
        slack_post text: input

        expect(text).to eq('$noun: coffee, peanut, and seashell')
      end
    end

    it_behaves_like 'list the values for $noun', 'Bucket: list values $noun'
  end

  context 'when Bucket is not addressed' do
    it 'does not respond' do
      slack_post text: 'list values $noun'

      expect(response.body).to eq '{}'
    end
  end
end
