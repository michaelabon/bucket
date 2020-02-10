class Noun < ApplicationRecord
  validates :what, presence: true
  validates :placed_by, presence: true
end
