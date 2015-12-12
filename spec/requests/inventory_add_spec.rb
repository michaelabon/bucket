require 'rails_helper'

describe 'Adding items to the inventory' do
  context 'when addressed' do
    context 'when the trigger matches' do
      it 'adds the item to the inventory' do
        slack_post text: 'Bucket, have an apple'

        expect(text).to eq '_is now carrying an apple_'

        slack_post text: 'Bucket, list your items'

        expect(text).to include 'an apple'
      end
    end

    context 'when the trigger does not match' do
      it 'does not add the item to the inventory' do
        slack_post text: 'Bucket, an apple'

        expect(response.body).to eq '{}'
      end
    end
  end

  context 'when not addressed' do
    context 'when the trigger matches' do
      it 'adds the item to the inventory' do
        slack_post text: 'puts an apple in Bucket'

        expect(text).to eq '_is now carrying an apple_'

        slack_post text: 'Bucket, list your items'

        expect(text).to include 'an apple'
      end
    end

    context 'when the trigger does not match' do
      it 'does not add the item to the inventory' do
        slack_post text: 'an apple'

        expect(response.body).to eq '{}'
      end
    end
  end
end
