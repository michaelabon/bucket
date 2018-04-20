require 'rails_helper'

describe Fact do
  describe 'validations' do
    it do
      is_expected.to validate_presence_of(:trigger)
    end

    it do
      is_expected.to validate_presence_of(:result)
    end
  end
end
