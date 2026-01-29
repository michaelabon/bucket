require 'rails_helper'

describe Bucket::Bucket do
  let(:bucket) do
    described_class.new(
      preprocessors:,
      processors:,
      postprocessors:,
    )
  end

  let(:preprocessors) { [] }
  let(:processors) { [] }
  let(:postprocessors) { [] }
  let(:message) { instance_double(Message, user_name: 'Doctor Who') }

  describe '#process' do
    describe 'processor order matters' do
      let(:processors) { [successful_processor, skipped_processor] }
      let(:successful_processor) { instance_double(Bucket::Processors::FactLookup) }
      let(:skipped_processor) { instance_double(Bucket::Processors::FactLookup) }
      let(:message_response) do
        instance_double(MessageResponse, text:, 'user_name=': nil)
      end

      context 'when the first processor has a positive result' do
        let(:text) { 'alpha' }

        before do
          allow(successful_processor).to receive(:process).with(message)
                                                          .and_return(message_response)
          allow(skipped_processor).to receive(:process)
        end

        it "returns the first processor's result" do
          result = bucket.process(message)

          expect(result).to eq 'alpha'
        end

        it 'does not call the second processor' do
          bucket.process(message)

          expect(skipped_processor).not_to have_received(:process)
        end
      end

      context 'when the first processor has a negative result' do
        let(:text) { 'bravo' }

        before do
          allow(successful_processor).to receive(:process).with(message)
                                                          .and_return(nil)
          allow(skipped_processor).to receive(:process).with(message)
                                                       .and_return(message_response)
        end

        it "returns the second processor's result" do
          result = bucket.process(message)

          expect(result).to eq 'bravo'
        end
      end
    end

    describe 'preprocessor order matters' do
      let(:preprocessors) { [first_preprocessor, second_preprocessor] }
      let(:first_preprocessor) { instance_double(Bucket::Preprocessors::HtmlDecode, process: true) }
      let(:second_preprocessor) { instance_double(Bucket::Preprocessors::HtmlDecode, process: true) }

      it 'calls the preprocessors' do
        bucket.process(message)

        expect(first_preprocessor).to have_received(:process).with(message)
        expect(second_preprocessor).to have_received(:process).with(message)
      end
    end

    # describe 'postprocessor order matters' do
    # let(:message_response) { instance_double(MessageResponse, text: 'result') }
    # let(:processors) { [instance_double(Bucket::Processors::FactLookup, process: message_response)] }

    # let(:postprocessors) { [postprocessor1, postprocessor2] }
    # let(:postprocessor1) { instance_double(Bucket::Postprocessors::EncodeHtml, process: 'result post-1') }
    # let(:postprocessor2) { instance_double(Bucket::Postprocessors::EncodeHtml, process: 'result post-2') }

    # it 'calls the postprocessors' do
    # expect(bucket.process(message)).to eq 'result post-2'

    # expect(postprocessor1).to have_received(:process).with('result')
    # expect(postprocessor2).to have_received(:process).with('result post-1')
    # end
    # end
  end
end
