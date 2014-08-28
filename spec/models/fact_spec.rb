require 'rails_helper'

describe Fact do
  describe 'validations' do
    it do
      should validate_presence_of(:trigger)
    end

    it do
      should validate_presence_of(:result)
    end
  end
end
