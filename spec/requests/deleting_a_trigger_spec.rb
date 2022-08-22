require 'rails_helper'

describe 'Deleting a trigger' do
  let(:trigger) { 'alpha' }

  before do
    create(:fact, trigger:, result: 'bravo one')
    create(:fact, trigger:, result: 'bravo two')
  end

  context 'when Bucket is addressed' do
    it 'deletes all facts with the trigger' do
      expect(Fact.count).to eq 2
      slack_post text: "Bucket: #{trigger}"

      expect(text).to match(/^bravo (?:one|two)$/)
      expect(Fact.count).to eq 2

      slack_post text: "Bucket: delete #{trigger}"

      expect(text).to eq "OK, M2K. I have deleted #{trigger}."
      expect(Fact.count).to eq 0
    end
  end

  context 'when Bucket is not addressed' do
    it 'does not delete anything' do
      slack_post text: "delete #{trigger}"

      expect(response.body).to eq '{}'
      expect(Fact.count).to eq 2
    end
  end
end
