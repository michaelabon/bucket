require 'rails_helper'

describe 'Addressing Bucket' do

  context 'Bucket is addressed' do
    it 'likes a line starting with its name, colon, and whitespace' do
      post '/messages', text: 'Bucket: "X" is "Y"',
        token: slack_token, user_name: 'M2K'

      expect(json['text']).to eq 'OK, M2K'
    end

    it 'likes a line starting with its name, comma, and whitespace' do
      post '/messages', text: 'Bucket, "X" is "Y"',
        token: slack_token, user_name: 'M2K'

      expect(json['text']).to eq 'OK, M2K'
    end

    it 'likes a line starting with an at-symbol, its name, and whitespace' do
      post '/messages', text: '@Bucket "X" is "Y"',
        token: slack_token, user_name: 'M2K'

      expect(json['text']).to eq 'OK, M2K'
    end

    it 'likes a line ending with a comma and its name' do
      post '/messages', text: '"X" is "Y", Bucket',
        token: slack_token, user_name: 'M2K'

      expect(json['text']).to eq 'OK, M2K'
    end

    it 'does not care about case' do
      post '/messages', text: 'bucket: "X" is "Y"',
        token: slack_token, user_name: 'M2K'

      expect(json['text']).to eq 'OK, M2K'
    end
  end

  context 'Bucket is not addressed' do
    it 'does not learn anything' do
      post '/messages', text: '"X" is "Y"',
        token: slack_token, user_name: 'M2K'

      expect(response.body).to eq '{}'
    end
  end
end
