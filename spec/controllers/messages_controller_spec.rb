require 'rails_helper'

describe MessagesController do
  describe '#receive' do
    let(:message) { double(:message, valid?: valid) }
    let(:bucket) { double(:bucket) }
    let(:valid) { false }

    before do
      allow(Message).to receive(:new) { message }
    end

    it 'permits only text, user_name, and token' do
      post :receive, params: {
        token: '123',
        text: 'alpha',
        user_name: 'M2K',
        extra: 'param',
      }

      expect(Message).to have_received(:new).with(
        ActionController::Parameters.new(
          token: '123',
          text: 'alpha',
          user_name: 'M2K',
        ).permit!,
      )
    end

    context 'when the message is valid' do
      let(:valid) { true }
      let(:message_response) { 'bravo' }

      before do
        allow(Bucket::Bucket).to receive(:new) { bucket }
        allow(bucket).to receive(:process).with(message)
                                          .and_return(message_response)
      end

      context 'when Bucket has a response' do
        let(:message_response) { 'bravo' }

        it 'responds with 200 OK' do
          post :receive

          expect(response).to be_successful
        end

        it 'responds with Bucket’s response' do
          post :receive, params: { text: 'alpha' }

          expect(response.parsed_body['text']).to eq 'bravo'
        end
      end

      context 'when Bucket has no response' do
        let(:message_response) { nil }

        it 'responds with 200 OK' do
          post :receive

          expect(response).to be_successful
        end

        it 'responds with nothing' do
          post :receive, params: { text: 'doesn’t match!' }

          expect(response.body).to eq '{}'
        end
      end
    end

    context 'when the message is invalid' do
      let(:valid) { false }

      it 'responds with 400' do
        post :receive, params: { text: 'alpha' }

        expect(response.status).to eq 400
      end
    end
  end
end
