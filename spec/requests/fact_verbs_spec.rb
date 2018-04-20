require 'rails_helper'

describe 'Using different verbs' do
  context 'when `<reply>`' do
    before do
      create(:fact, trigger: 'alpha', result: 'bravo', verb: '<reply>')
    end

    it 'responds with the matching factoid' do
      slack_post text: 'alpha'

      expect(text).to eq 'bravo'
    end
  end

  context 'when `<action>`' do
    before do
      create(:fact, trigger: 'alpha', result: 'bravo', verb: '<action>')
    end

    it 'responds with a formatted action' do
      slack_post text: 'alpha'

      expect(text).to eq '_bravo_'
    end
  end

  context 'when `is`' do
    it 'responds with the full sentence' do
      slack_post text: 'Bucket, alpha is bravo'

      expect(text).to eq 'OK, M2K'

      slack_post text: 'alpha'

      expect(text).to eq 'alpha is bravo'
    end
  end

  context 'when `are`' do
    it 'responds with the full sentence' do
      slack_post text: 'Cheetahs are delicious, Bucket'

      expect(text).to eq 'OK, M2K'

      slack_post text: 'Cheetahs'

      expect(text).to eq 'Cheetahs are delicious'
    end
  end

  context 'when arbitrary `<verb>` construct' do
    it 'responds with the full sentence' do
      slack_post text: 'People <read> books, Bucket'

      expect(text).to eq 'OK, M2K'

      slack_post text: 'People'

      expect(text).to eq 'People read books'
    end
  end
end
