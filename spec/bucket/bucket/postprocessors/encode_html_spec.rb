require 'spec_helper'

RSpec.describe Bucket::Postprocessors::EncodeHtml do
  let(:processor) { described_class.new }

  describe '#process' do
    let(:message_response) { MessageResponse.new(text:) }

    context 'when the response contains &' do
      let(:text) { 'A & B' }

      specify do
        processor.process(message_response)

        expect(message_response.text).to eq 'A &amp; B'
      end
    end

    context 'when the response contains <' do
      let(:text) { '2 < 3' }

      specify do
        processor.process(message_response)

        expect(message_response.text).to eq '2 &lt; 3'
      end
    end

    context 'when the response contains >' do
      let(:text) { '3 > 2' }

      specify do
        processor.process(message_response)

        expect(message_response.text).to eq '3 &gt; 2'
      end
    end

    context 'when there is no response' do
      let(:message_response) { nil }

      specify do
        processor.process(message_response)

        expect(message_response).to be_nil
      end
    end

    context 'when response is empty' do
      let(:message_response) { MessageResponse.new(text: nil) }

      specify do
        processor.process(message_response)

        expect(message_response.text).to be_nil
      end
    end
  end
end
