require 'rails_helper'

describe 'Performing /me actions' do

  it 'understands the <action> verb' do
    slack_post text: '@Bucket monkey <action> hides'
    slack_post text: 'monkey'

    expect(json['text']).to eq '_hides_'
  end
end
