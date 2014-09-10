require 'rails_helper'

describe 'Performing /me actions' do

  it 'understands the <action> verb' do
    post '/messages', text: '@Bucket "monkey" <action> "hides"',
                      token: slack_triggers_token
    post '/messages', text: 'monkey', token: slack_triggers_token

    expect(json['text']).to eq '_hides_'
  end
end
