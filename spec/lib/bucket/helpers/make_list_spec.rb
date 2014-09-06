require 'rails_helper'

describe Bucket::Helpers::MakeList do
  describe '#make_list' do
    subject { described_class.make_list items }

    context '0 items' do
      let(:items) { [] }

      specify do
        expect(described_class.make_list(items)).to eq '[none]'
      end
    end

    context '1 item' do
      let(:items) { ['a'] }

      specify do
        expect(described_class.make_list(items)).to eq 'a'
      end
    end

    context '2 items' do
      let(:items) { %w(a b) }

      specify do
        expect(described_class.make_list(items)).to eq 'a and b'
      end
    end

    context '3 items' do
      let(:items) { %w(a b c) }

      specify do
        expect(described_class.make_list(items)).to eq 'a, b, and c'
      end
    end

    context 'more items' do
      let(:items) { %w(a b c d e) }

      specify do
        expect(described_class.make_list(items)).to eq 'a, b, c, d, and e'
      end
    end
  end
end
