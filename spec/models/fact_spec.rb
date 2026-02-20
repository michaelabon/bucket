require 'rails_helper'

RSpec.describe Fact do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:trigger) }

    it { is_expected.to validate_presence_of(:result) }
  end
end
