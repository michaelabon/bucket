# A learned trigger-response pair that Bucket can recall.
#
# Facts are the core of Bucket's knowledge.
# Users teach Bucket by saying things like "X is Y" or "X <verb> Y",
# and Bucket stores these as facts it can later retrieve
# when someone says the trigger phrase.
class Fact < ApplicationRecord
  validates :trigger, presence: true
  validates :result, presence: true
end
