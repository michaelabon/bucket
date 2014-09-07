require 'rails_helper'

describe 'Learning factoids' do

  context 'Bucket is addressed' do
    context 'the factoid is new' do
      it 'learns the factoid' do
        post '/messages', text: 'Bucket: "X" <reply> "Y"',
          token: slack_triggers_token, user_name: 'M2K'

        expect(json['text']).to eq 'OK, M2K'

        post '/messages', text: 'X', token: slack_triggers_token

        expect(json['text']).to eq 'Y'
      end
    end

    context 'the trigger is old but the result is new' do
      before do
        create(:fact, trigger: 'X', result: 'Y')
      end

      it 'learns the factoid' do
        post '/messages', text: 'Bucket, "X" <reply> "Z"',
          token: slack_triggers_token, user_name: 'M2K'

        expect(json['text']).to eq 'OK, M2K'

        # QUESTION: How to test random responses?
        expect(Fact.find_by(trigger: 'X', result: 'Z')).to be
      end
    end

    context 'the factoid already exists' do
      before do
        create(:fact, trigger: 'X', result: 'Y')
      end

      it 'pretends to learn the factoid' do
        post '/messages', text: '@Bucket "X" <reply> "Y"',
          token: slack_triggers_token, user_name: 'M2K'

        expect(json['text']).to eq 'OK, M2K'
        expect(Fact.count).to eq 1
      end
    end
  end

  context 'Bucket is not addressed' do
    it 'does nothing' do
      post '/messages', text: 'Chump: "X" <reply> "Y"',
        token: slack_triggers_token, user_name: 'M2K'

      expect(response.body).to eq '{}'
    end
  end
end
