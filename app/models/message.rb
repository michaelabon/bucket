class Message
  include ActiveModel::Validations

  attr_accessor :token, :team_id, :channel_id, :channel_name, :timestamp,
                :user_id, :user_name, :text, :trigger_word

  validates :token, presence: true, inclusion: {
    in: [Rails.application.secrets[:slack_token]]
  }

  def initialize(options = {})
    options = options.with_indifferent_access

    @token = options[:token]
    @team_id = options[:team_id]
    @channel_id = options[:channel_id]
    @channel_name = options[:channel_name]
    @timestamp = options[:timestamp]
    @user_id = options[:user_id]
    @user_name = options[:user_name]
    @text = options[:text]
    @trigger_word = options[:trigger_word]
  end
end
