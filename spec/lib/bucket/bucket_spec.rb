require 'rails_helper'

describe Bucket::Bucket do
  let(:bucket) do
    described_class.new(
      preprocessors: preprocessors,
      processors: processors,
      postprocessors: postprocessors,
    )
  end

  let(:preprocessors) { [] }
  let(:processors) { [] }
  let(:postprocessors) { [] }
  let(:message) { double(:message) }

  describe '#process' do
    describe 'processor order matters' do
      let(:processors) { [processor1, processor2] }
      let(:processor1) { double(:processor1) }
      let(:processor2) { double(:processor2) }
      let(:message_response) { double(:message_response, text: text) }

      context 'first processor has a positive result' do
        let(:text) { 'alpha' }

        before do
          allow(processor1).to receive(:process).with(message).
            and_return(message_response)
        end

        it 'returns the first processor’s result' do
          result = bucket.process(message)

          expect(result).to eq 'alpha'
        end

        it 'does not call the second processor' do
          expect(processor2).not_to receive(:process)

          bucket.process(message)
        end
      end

      context 'first processor has a negative result' do
        before do
          allow(processor1).to receive(:process).with(message).
            and_return(nil)
          allow(processor2).to receive(:process).with(message).
            and_return(double(text: 'bravo'))
        end

        it 'returns the second processor’s result' do
          result = bucket.process(message)

          expect(result).to eq 'bravo'
        end
      end
    end

    describe 'preprocessor order matters' do
      let(:preprocessors) { [preprocessor1, preprocessor2] }
      let(:preprocessor1) { double(:preprocessor1, process: true) }
      let(:preprocessor2) { double(:preprocessor2, process: true) }

      it 'calls the preprocessors' do
        bucket.process(message)

        expect(preprocessor1).to have_received(:process).with(message)
        expect(preprocessor2).to have_received(:process).with(message)
      end
    end

    # describe 'postprocessor order matters' do
    # let(:message_response) { double(:message_response, text: 'result') }
    # let(:processors) { [double(:processor, process: message_response)] }

    # let(:postprocessors) { [postprocessor1, postprocessor2] }
    # let(:postprocessor1) { double(:postprocessor1, process: 'result post-1') }
    # let(:postprocessor2) { double(:postprocessor2, process: 'result post-2') }

    # it 'calls the postprocessors' do
    # expect(bucket.process(message)).to eq 'result post-2'

    # expect(postprocessor1).to have_received(:process).with('result')
    # expect(postprocessor2).to have_received(:process).with('result post-1')
    # end
    # end
  end
end
