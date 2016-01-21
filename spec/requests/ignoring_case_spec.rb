require 'rails_helper'

describe 'Ignoring case' do
  it 'ignores case in fact triggers' do
    trigger = 'alpha Bravo'
    reply = 'You cannot fool me.'

    slack_post text: %(Bucket: #{trigger} <reply> #{reply})

    expect(text).to eq 'OK, M2K'

    slack_post text: 'AlPhA bRaVo'

    expect(text).to eq reply
  end

  it 'ignores case in fact deletion' do
    slack_post text: 'Bucket: UPPERcase <reply> lowercase'

    expect(text).to eq 'OK, M2K'

    slack_post text: 'upperCASE'

    expect(text).to eq 'lowercase'

    slack_post text: 'Bucket: delete uPpeRcAsE'

    expect(text).to eq 'OK, M2K. I have deleted uppercase.'
  end
end
