url = "https://#{Rails.application.secrets[:slack_subdomain]}.slack.com/services/hooks/incoming-webhook?token=#{Rails.application.secrets[:slack_startup_token]}"
HTTParty.post(
  url,
  body: %Q[{"text": "Hello, world!"}]
)
