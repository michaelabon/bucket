require 'rails_helper'

describe Message do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:token) }
    it do
      is_expected
        .to validate_inclusion_of(:token)
        .in_array([Rails.configuration.x.slack.triggers_token])
    end
  end
end
