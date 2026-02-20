require 'rails_helper'

RSpec.describe Bucket::Helpers::CleanPunctuation do
  describe 'removals' do
    it 'removes exclamation marks' do
      expect(described_class.clean('!a!b!')).to eq 'ab'
    end

    it 'removes double quotes' do
      expect(described_class.clean('"a"b"')).to eq 'ab'
    end

    it 'removes single quotes' do
      expect(described_class.clean("'a'b'")).to eq 'ab'
    end

    it 'removes LEFT SINGLE QUOTATION MARKS' do
      expect(described_class.clean('‘ab')).to eq 'ab'
    end

    it 'removes RIGHT SINGLE QUOTATION MARKS' do
      expect(described_class.clean('ab’')).to eq 'ab'
    end

    it 'removes LEFT DOUBLE QUOTATION MARKS' do
      expect(described_class.clean('“ab')).to eq 'ab'
    end

    it 'removes RIGHT DOUBLE QUOTATION MARKS' do
      expect(described_class.clean('ab"')).to eq 'ab'
    end

    it 'removes parentheses' do
      expect(described_class.clean('(a)(b)')).to eq 'ab'
    end

    it 'removes commas' do
      expect(described_class.clean(',a,b,')).to eq 'ab'
    end

    it 'removes periods' do
      expect(described_class.clean('.a.b.')).to eq 'ab'
    end

    it 'removes question marks' do
      expect(described_class.clean('?a?b?')).to eq 'ab'
    end

    it 'removes brackets' do
      expect(described_class.clean('[a][b]')).to eq 'ab'
    end

    it 'removes braces' do
      expect(described_class.clean('{a}{b}')).to eq 'ab'
    end
  end

  describe 'marks that are not removed' do
    it 'does not remove dollar signs' do
      expect(described_class.clean('$a$b$')).to eq '$a$b$'
    end

    it 'does not remove ampersands' do
      expect(described_class.clean('&a&b&')).to eq '&a&b&'
    end

    it 'does not remove asterisks' do
      expect(described_class.clean('*a*b*')).to eq '*a*b*'
    end

    it 'does not remove pluses' do
      expect(described_class.clean('+a+b+')).to eq '+a+b+'
    end

    it 'does not remove hyphens' do
      expect(described_class.clean('-a-b-')).to eq '-a-b-'
    end

    it 'does not remove angle brackets' do
      expect(described_class.clean('<a><b>')).to eq '<a><b>'
    end

    it 'does not remove equals' do
      expect(described_class.clean('=a=b=')).to eq '=a=b='
    end
  end
end
