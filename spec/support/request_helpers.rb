module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end
  end

  module SlackToken
    def slack_token
      Rails.application.secrets['slack_token']
    end
  end
end
