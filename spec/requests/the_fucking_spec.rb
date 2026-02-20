require 'rails_helper'

RSpec.describe 'Reverse `the fucking` into `fucking the`' do
  it 'reverses the order of `the fucking`' do
    slack_post(text: 'the fucking bus')

    expect(text).to eq('fucking the bus')
  end
end
