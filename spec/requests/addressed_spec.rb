require 'rails_helper'

describe 'Addressing Bucket' do
  context 'when Bucket is addressed' do
    it 'likes a line starting with its name, colon, and whitespace' do
      slack_post text: 'Bucket: X <reply> Y'

      expect(text).to eq 'OK, M2K'
    end

    it 'likes a line starting with its name, comma, and whitespace' do
      slack_post text: 'Bucket, X <reply> Y'

      expect(text).to eq 'OK, M2K'
    end

    it 'likes a line starting with an at-symbol, its name, and whitespace' do
      slack_post text: '@Bucket X <reply> Y'

      expect(text).to eq 'OK, M2K'
    end

    it 'likes a line ending with a comma and its name' do
      slack_post text: 'X <reply> Y, Bucket'

      expect(text).to eq 'OK, M2K'
    end

    it 'does not care about case' do
      slack_post text: 'bucket: X <reply> Y'

      expect(text).to eq 'OK, M2K'
    end
  end

  context 'when Bucket is not addressed' do
    it 'does not learn anything' do
      slack_post text: 'X <reply> Y'

      expect(response.body).to eq '{}'
    end
  end
end
