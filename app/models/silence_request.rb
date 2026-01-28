# A temporary mute request that tells Bucket to stop responding.
#
# When users tell Bucket to "shut up" or "go away",
# a silence request is created with an expiration time.
# While any unexpired request exists,
# Bucket ignores all messages.
# This lets channels have quiet time during heavy conversations
# without removing Bucket entirely.
class SilenceRequest < ApplicationRecord
  validates :requester, presence: true
  validates :silence_until, presence: true

  def self.request_active?
    where('silence_until > ?', Time.zone.now).exists?
  end
end
