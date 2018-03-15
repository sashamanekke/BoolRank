class Poll < ApplicationRecord
  belongs_to :user
  has_many :participants, dependent: :destroy
  has_many :propositions, dependent: :destroy
  has_many :votes, dependent: :destroy
  #validations
  validates :title, presence: true

  def self.compute_percentage(poll, session_user_id)
    remaining = Poll.generate_existing_combinations(poll.votes.where(session_user_id: session_user_id))
    total = Poll.generate_combinations(poll.propositions)
    percentage = (remaining.length.to_f)/(total.length.to_f)
    return (percentage*100).to_i
  end

  def self.compute_total_score(poll)
    total_score = 0
    prop_lenth = poll.propositions.length
    poll.propositions.each do |prop|
      total_score += prop.score
    end
    total_score
  end

  def self.compute_remaining_combinations(poll, session_user_id)
    #generate the basic combinations => [1,2] [3,4] [5,6] ..."
    first_combinations = Poll.generate_first_combinations(poll.propositions)
    #generate all the combinations already voted by the current user
    existing_combinations = Poll.generate_existing_combinations(poll.votes.where(session_user_id: session_user_id))
    #@poll.votes.where(user_id: current_user.id))
    #compute the remaining combinations
    remaining_combinations = (first_combinations - existing_combinations)
    all_combinations = Poll.generate_combinations(poll.propositions)
    if remaining_combinations == []
      remaining_combinations = (all_combinations - existing_combinations)
    end
    remaining_combinations
  end

  def self.generate_first_combinations(props)
    props = props.sort { |a, b|  a.id <=> b.id }
    first_combinations = []
    props.each_slice(2) do |slice|
      if props.length.odd? && slice.first == props.last
        slice << props.first
      end
      slice.sort! { |a, b|  a.id <=> b.id }
      first_combinations << slice
    end
    first_combinations.sort!
  end

  def self.generate_existing_combinations(votes)
    existing_combinations = []
    votes.each do |vote|
      combination = [vote.accepted_proposition, vote.rejected_proposition]
      combination.sort! { |a, b|  a.id <=> b.id }
      existing_combinations << combination
    end
    existing_combinations
  end

  def self.generate_combinations(props)
    props = props.sort { |a, b|  a.id <=> b.id }
    all_combinations = []
    props.each_with_index do |p1, index|
      props[(index + 1)..-1].each do |p2|
        all_combinations << [p1,p2].sort! { |a, b|  a.id <=> b.id }
      end
    end
    all_combinations
  end

end
