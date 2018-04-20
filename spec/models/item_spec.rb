require 'rails_helper'

describe Item do
  describe 'validations' do
    it do
      is_expected.to validate_presence_of(:what)
    end

    it do
      is_expected.to validate_presence_of(:placed_by)
    end
  end
end
