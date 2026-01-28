# A user-taught noun for the `$noun` variable substitution.
#
# When Bucket's responses contain `$noun`,
# a random noun from this table is substituted in.
# Users can teach Bucket new nouns
# to expand the pool of random substitutions,
# making responses more varied and contextual.
class Noun < ApplicationRecord
  validates :what, presence: true
  validates :placed_by, presence: true
end
