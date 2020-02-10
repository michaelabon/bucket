require 'rails_helper'

describe 'Adding a $noun' do
  context 'when Bucket is addressed' do
    describe "learning the noun" do
      it 'understands `add value $noun book`' do
        slack_post text: 'Bucket: add value $noun book'

        expect(text).to eq "Okay, M2K, 'book' is now a noun."
      end

      it 'understands `add value book $noun`' do
        slack_post text: 'Bucket: add value book $noun'

        expect(text).to eq "Okay, M2K, 'book' is now a noun."
      end

      it 'understands `add book to $noun`' do
        slack_post text: 'Bucket: add book to $noun'

        expect(text).to eq "Okay, M2K, 'book' is now a noun."
      end
    end

    describe "using the noun later" do
      it "can replace $noun with the new noun" do
        slack_post text: "@Bucket add value $noun chair"
        slack_post text: "@Bucket You're a towel <reply> You're a $noun!"
        slack_post text: "You're a towel"

        expect(text).to eq "You're a chair!"
      end
    end
  end

  context 'when Bucket is not addressed' do
    it 'does not respond' do
      slack_post text: 'add value $noun book'

      expect(response.body).to eq '{}'
    end
  end
end
