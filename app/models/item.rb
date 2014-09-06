class Item < ActiveRecord::Base
  validates :what, presence: true
  validates :placed_by, presence: true
end
