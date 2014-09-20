require 'rails_helper'

describe 'Using different verbs' do

  context 'Using `<reply>`' do
    before do
      create(:fact, trigger: 'alpha', result: 'bravo', verb: '<reply>')
    end

    it 'responds with the matching factoid' do
      slack_post text: 'alpha'

      expect(json['text']).to eq 'bravo'
    end
  end

  context 'Using `<action>`' do
    before do
      create(:fact, trigger: 'alpha', result: 'bravo', verb: '<action>')
    end

    it 'responds with a formatted action' do
      slack_post text: 'alpha'

      expect(json['text']).to eq '_bravo_'
    end
  end

  context 'Using `is`' do
    it 'responds with the full sentence' do
      slack_post text: 'Bucket, alpha is bravo'

      expect(json['text']).to eq 'OK, M2K'

      slack_post text: 'alpha'

      expect(json['text']).to eq 'alpha is bravo'
    end
  end

  context 'Using `are`' do
    it 'responds with the full sentence' do
      slack_post text: 'Cheetahs are delicious, Bucket'

      expect(json['text']).to eq 'OK, M2K'

      slack_post text: 'Cheetahs'

      expect(json['text']).to eq 'Cheetahs are delicious'
    end
  end
end
