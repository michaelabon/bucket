require 'rails_helper'

describe Message do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:token) }
    it do
      is_expected
        .to validate_inclusion_of(:token)
        .in_array([Rails.application.credentials.slack_triggers_token!])
    end
  end
end
