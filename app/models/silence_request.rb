class SilenceRequest < ActiveRecord::Base
  validates :requester, presence: true
  validates :silence_until, presence: true

  def self.request_active?
    where('silence_until > ?', Time.zone.now).exists?
  end
end
