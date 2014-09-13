module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end
  end

  module SlackPost
    def slack_post(
      path: '/messages',
      text: '',
      token: slack_triggers_token,
      user_name: 'M2K'
    )
      post path, text: text, token: token, user_name: user_name
    end
  end

  module SlackToken
    def slack_triggers_token
      Rails.application.secrets['slack_triggers_token']
    end
  end
end
