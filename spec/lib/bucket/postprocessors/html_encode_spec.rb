require 'rails_helper'

describe Bucket::Postprocessors::HtmlEncode do
  let(:processor) { described_class.new }

  describe '#process' do
    it 'converts &' do
      expect(processor.process('A & B')).to eq 'A &amp; B'
    end

    it 'converts <' do
      expect(processor.process('2 < 3')).to eq '2 &lt; 3'
    end

    it 'converts >' do
      expect(processor.process('3 > 2')).to eq '3 &gt; 2'
    end

    it 'handles nils' do
      expect(processor.process(nil)).to eq nil
    end
  end

end
