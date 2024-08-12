module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end

    def text
      json['text']
    end
  end

  module SlackPost
    def slack_post(
      path: '/messages',
      text: '',
      token: slack_triggers_token,
      user_name: 'M2K'
    )
      post path, params: { text:, token:, user_name: }
    end
  end

  module SlackToken
    def slack_triggers_token
      Rails.application.credentials.slack_triggers_token!
    end
  end
end
