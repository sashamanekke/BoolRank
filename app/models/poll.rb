class Poll < ApplicationRecord
  belongs_to :user
  has_many :participants, dependent: :destroy
  has_many :propositions, dependent: :destroy
  has_many :votes, dependent: :destroy
end
