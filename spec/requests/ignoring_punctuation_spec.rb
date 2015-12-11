require 'rails_helper'

describe 'Ignoring punctuation' do
  it 'ignores certain punctuation in triggers' do
    trigger = %q(ig'no"re t!his? p{unc.tua,tion)
    reply = 'Understood! -- Ignoring.'

    slack_post text: %(Bucket: #{trigger} <reply> #{reply})

    expect(text).to eq 'OK, M2K'

    slack_post text: %q(Bucket: "i.gno!re t?hi}s pu,nctu(ati)on')

    expect(text).to eq reply
  end
end
