require 'rails_helper'

describe 'Shutting up on command' do
  before do
    create(:fact, trigger: 'alpha', result: 'bravo', verb: '<reply>')
  end

  it 'shuts up on command' do
    slack_post text: 'alpha'

    expect(text).to eq 'bravo'

    slack_post text: 'Bucket: shut up'

    expect(text).to eq 'Okay, M2K. Be back in a bit.'

    slack_post text: 'alpha'

    expect(response.body).to eq '{}'
  end
end
