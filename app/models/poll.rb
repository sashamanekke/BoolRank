class Poll < ApplicationRecord
  belongs_to :user
  has_many :participants
  has_many :propositions
  has_many :votes
end
