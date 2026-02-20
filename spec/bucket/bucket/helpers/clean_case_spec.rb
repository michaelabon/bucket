require 'rails_helper'

RSpec.describe Bucket::Helpers::CleanCase do
  describe 'cleaning character cases' do
    it 'lower cases the text' do
      input = 'AmZ'
      output = 'amz'

      expect(described_class.clean(input)).to eq output
    end

    it 'works outside ASCII' do
      input = 'VĚDA A VÝZKUM'
      output = 'věda a výzkum'

      expect(described_class.clean(input)).to eq output
    end
  end

  describe 'unexpected inputs' do
    it 'handles a nil input' do
      expect(described_class.clean(nil)).to eq ''
    end
  end
end
