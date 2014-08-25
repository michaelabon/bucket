class Fact < ActiveRecord::Base
  validates :trigger, :presence
  validates :re, :presence
  validates :fact, :presence
  validates :protected, :presence
end
