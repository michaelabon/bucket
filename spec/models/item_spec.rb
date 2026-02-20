require 'rails_helper'

RSpec.describe Item do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:what) }

    it { is_expected.to validate_presence_of(:placed_by) }
  end
end
