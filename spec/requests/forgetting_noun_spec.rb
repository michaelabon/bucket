require 'rails_helper'

RSpec.describe 'Forgetting a $noun' do
  context 'when Bucket is addressed' do
    context 'when the noun is known' do
      before do
        Noun.create!(
          what: 'book',
          placed_by: 'M2K',
        )
      end

      describe 'forgetting the noun' do
        it 'understands `forget value $noun book`' do
          slack_post text: 'Bucket: forget value $noun book'

          expect(text).to eq "Okay, M2K, 'book' is no longer a noun."
        end

        it 'understands `forget value book $noun`' do
          slack_post text: 'Bucket: forget value book $noun'

          expect(text).to eq "Okay, M2K, 'book' is no longer a noun."
        end
      end
    end

    context 'when the noun is not known' do
      it 'acknowledges the user’s mistake' do
        slack_post text: 'Bucket: forget value $noun book'

        expect(text).to eq "I'm sorry, M2K, but 'book' is not a noun that I know of."
      end
    end
  end

  context 'when Bucket is not addressed' do
    it 'does not respond' do
      slack_post text: 'forget value $noun book'

      expect(response.body).to eq '{}'
    end
  end
end
