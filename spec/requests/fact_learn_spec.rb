require 'rails_helper'

describe 'Learning factoids' do
  context 'when Bucket is addressed' do
    context 'when the factoid is new' do
      it 'learns the factoid' do
        slack_post text: 'Bucket: less is more! &lt;reply&gt; more is less!'

        expect(text).to eq 'OK, M2K'

        slack_post text: 'less is more'

        expect(text).to eq 'more is less!'
      end
    end

    context 'when the trigger is old but the result is new' do
      before do
        create(:fact, trigger: 'x', result: 'Y')
      end

      it 'learns the factoid' do
        slack_post text: 'Bucket, x &lt;reply&gt; Z'

        expect(text).to eq 'OK, M2K'

        # QUESTION: How to test random responses?
        expect(Fact.find_by(trigger: 'x', result: 'Z')).not_to be_nil
      end
    end

    context 'when the factoid already exists' do
      before do
        create(:fact, trigger: 'x', result: 'Y', verb: '<reply>')
      end

      it 'pretends to learn the factoid' do
        expect { slack_post text: '@Bucket x &lt;reply&gt; Y' }
          .not_to change(Fact, :count)

        expect(text).to eq 'OK, M2K'
        expect(Fact.count).to eq 1
      end
    end
  end

  context 'when Bucket is not addressed' do
    it 'does nothing' do
      slack_post text: 'Chump: x &lt;reply&gt; Y'

      expect(response.body).to eq '{}'
    end
  end
end
