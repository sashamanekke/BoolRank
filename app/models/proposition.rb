class Proposition < ApplicationRecord
  belongs_to :poll
  has_many :accepted_proposition_vote, :class_name => "Vote", :foreign_key => 'accepted_proposition_id'
  has_many :rejected_proposition_vote, :class_name => "Vote", :foreign_key => 'rejected_proposition_id'
end
