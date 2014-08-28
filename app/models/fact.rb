class Fact < ActiveRecord::Base
  validates :trigger, presence: true
  validates :result, presence: true
end
