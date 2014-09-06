require 'rails_helper'

describe Item do
  describe 'validations' do
    it do
      should validate_presence_of(:what)
    end

    it do
      should validate_presence_of(:placed_by)
    end
  end
end
