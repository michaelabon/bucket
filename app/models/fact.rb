class Fact < ApplicationRecord
  validates :trigger, presence: true
  validates :result, presence: true
end
