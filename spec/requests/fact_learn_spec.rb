require 'rails_helper'

describe 'Learning factoids' do

  context 'Bucket is addressed' do
    context 'the factoid is new' do
      it 'learns the factoid' do
        slack_post text: 'Bucket: X &lt;reply&gt; Y!'

        expect(json['text']).to eq 'OK, M2K'

        slack_post text: 'X'

        expect(json['text']).to eq 'Y!'
      end
    end

    context 'the trigger is old but the result is new' do
      before do
        create(:fact, trigger: 'X', result: 'Y')
      end

      it 'learns the factoid' do
        slack_post text: 'Bucket, X &lt;reply&gt; Z'

        expect(json['text']).to eq 'OK, M2K'

        # QUESTION: How to test random responses?
        expect(Fact.find_by(trigger: 'X', result: 'Z')).to be
      end
    end

    context 'the factoid already exists' do
      before do
        create(:fact, trigger: 'X', result: 'Y', verb: '<reply>')
      end

      it 'pretends to learn the factoid' do
        slack_post text: '@Bucket X &lt;reply&gt; Y'

        expect(json['text']).to eq 'OK, M2K'
        expect(Fact.count).to eq 1
      end
    end
  end

  context 'Bucket is not addressed' do
    it 'does nothing' do
      slack_post text: 'Chump: X &lt;reply&gt; Y'

      expect(response.body).to eq '{}'
    end
  end
end
