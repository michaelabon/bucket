require 'rails_helper'

describe MessagesController do
  describe '#receive' do
    let(:message) { double(:message) }
    let(:message_response) { { text: 'bravo' } }

    before do
      allow(Bucket::Bucket).to receive(:new) { bucket }
      allow(Message).to receive(:new) { message }
      allow(bucket).to receive(:receive_chat_message).with(message).
        and_return(message_response)
    end

    it 'responds with bravo' do
      post '/messages/receive', body: {
        'user_id' => 123,
        'text' => 'alpha'
      }

      expect(response.body['text']).to eq 'bravo'
    end

    it 'permits only user_id and text' do
      post '/messages/receive', body: {
        'user_id' => 123,
        'text' => 'alpha',
        'extra' => 'param'
      }

      expect(Message).to have_received(:new).with(
        user_id: 123,
        text: 'alpha'
      )
    end
  end
end
