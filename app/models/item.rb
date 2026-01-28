# Something in Bucket's inventory that a user has given it.
#
# Bucket maintains a virtual inventory of items users have "given" it.
# These items can be listed,
# referenced in responses via `$item`,
# or "given away" when a response uses `$giveitem`.
class Item < ApplicationRecord
  validates :what, presence: true
  validates :placed_by, presence: true
end
