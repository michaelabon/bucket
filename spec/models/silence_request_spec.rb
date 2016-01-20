require 'rails_helper'

describe SilenceRequest do
  describe 'validations' do
    it do
      should validate_presence_of(:requester)
    end

    it do
      should validate_presence_of(:silence_until)
    end
  end

  describe '.request_active?' do
    context 'when there is a SilenceRequest in the future' do
      it 'returns true' do
        create(:silence_request)

        expect(SilenceRequest.request_active?).to eq true
      end
    end

    context 'when there is a SilenceRequest in the past' do
      it 'returns false' do
        create(:silence_request, :expired)

        expect(SilenceRequest.request_active?).to eq false
      end
    end

    context 'when there is a SilenceRequest in the future and in the past' do
      it 'returns true' do
        create(:silence_request)
        create(:silence_request, :expired)

        expect(SilenceRequest.request_active?).to eq true
      end
    end

    context 'when there are no SilenceRequests' do
      it 'returns false' do
        expect(SilenceRequest.request_active?).to eq false
      end
    end
  end
end
