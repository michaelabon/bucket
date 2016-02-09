require 'rails_helper'

describe 'Shutting up on command' do
  before do
    create(:fact, trigger: 'alpha', result: 'bravo', verb: '<reply>')
  end

  it 'shuts up on command' do
    say_fact
    expect_bucket_to_respond

    slack_post text: 'Bucket: shut up'

    expect(text).to eq 'Okay, M2K. Be back in a bit.'

    say_fact
    expect_silence
  end

  describe 'Unshutting up' do
    it 'gives a helpful message if not shut up' do
      slack_post text: 'Bucket: unshut up'

      expect(text).to eq 'But M2K, I am already here.'

      say_fact
      expect_bucket_to_respond
    end

    it 'resumes normal behavior after being told to come back' do
      slack_post text: 'Bucket: shut up'
      slack_post text: 'Bucket: unshut up'

      say_fact
      expect_bucket_to_respond
    end
  end
end

def say_fact
  slack_post text: 'alpha'
end

def expect_bucket_to_respond
  expect(text).to eq 'bravo'
end

def expect_silence
  expect(response.body).to eq '{}'
end
