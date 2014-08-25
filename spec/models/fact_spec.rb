require 'rails_helper'

describe Fact do
  describe 'validations' do
    it do
      should validate_presence_of(:fact)
    end

    it do
      should validate_presence_of(:trigger)
    end
  end
end
