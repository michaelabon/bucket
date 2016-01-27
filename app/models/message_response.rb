class MessageResponse
  attr_accessor :text, :trigger, :user_name, :verb

  def initialize(text: nil, trigger: nil, user_name: nil, verb: nil)
    @text = text
    @trigger = trigger
    @user_name = user_name
    @verb = verb
  end
end
