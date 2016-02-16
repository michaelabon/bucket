# Public: Used to stop processing without posting a reply to the conversation.
# For example, when Bucket has been asked to be silent.
#
# Relies on the fact that Processors return an Object
# when they have handled the Message,
# and that a blank MessageResponse.text is ignored.
class BlankMessageResponse < MessageResponse
  def initialize(text: '', trigger: nil, user_name: nil, verb: nil)
    super
  end
end
