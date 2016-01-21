class SilenceRequest < ActiveRecord::Base
  validates_presence_of :requester, :silence_until

  def self.request_active?
    where('silence_until > ?', Time.zone.now).exists?
  end
end
