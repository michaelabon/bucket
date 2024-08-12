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
      token: SlackToken.slack_triggers_token,
      user_name: 'M2K'
    )
      post path, params: { text:, token:, user_name: }
    end
  end

  module SlackToken
    def self.slack_triggers_token
      Rails.configuration.x.slack.triggers_token
    end
  end
end
