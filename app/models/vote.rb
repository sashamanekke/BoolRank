class Vote < ApplicationRecord
  belongs_to :poll
  belongs_to :user
  belongs_to :accepted_proposition, :class_name => 'Proposition'
  belongs_to :rejected_proposition, :class_name => 'Proposition'
end
