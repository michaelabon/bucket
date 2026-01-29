require 'spec_helper'

describe Bucket::Preprocessors::HtmlDecode do
  let(:processor) { described_class.new }
  let(:message) { Message.new(text:) }

  context 'when the message is present' do
    let(:text) { 'A&amp;B&lt;C&gt;' }

    it 'decodes HTML encoding' do
      processor.process(message)

      expect(message.text).to eq 'A&B<C>'
    end
  end

  context 'when the message is nil' do
    let(:text) { nil }

    specify do
      processor.process(message)

      expect(message.text).to be_nil
    end
  end
end
