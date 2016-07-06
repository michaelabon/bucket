require 'spec_helper'

describe Bucket::Postprocessors::EncodeHtml do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:message_response) { MessageResponse.new(text: text) }

    context 'contains &' do
      let(:text) { 'A & B' }

      specify do
        processor.process(message_response)

        expect(message_response.text).to eq 'A &amp; B'
      end
    end

    context 'contains <' do
      let(:text) { '2 < 3' }

      specify do
        processor.process(message_response)

        expect(message_response.text).to eq '2 &lt; 3'
      end
    end

    context 'contains >' do
      let(:text) { '3 > 2' }

      specify do
        processor.process(message_response)

        expect(message_response.text).to eq '3 &gt; 2'
      end
    end

    context 'no response' do
      let(:message_response) { nil }

      specify do
        processor.process(message_response)

        expect(message_response).to eq nil
      end
    end

    context 'empty response' do
      let(:message_response) { MessageResponse.new(text: nil) }

      specify do
        processor.process(message_response)

        expect(message_response.text).to eq nil
      end
    end
  end
end
