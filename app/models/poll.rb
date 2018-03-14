class Poll < ApplicationRecord
  belongs_to :user
  has_many :participants, dependent: :destroy
  has_many :propositions, dependent: :destroy
  has_many :votes, dependent: :destroy
  #validations
  validates :title, presence: true

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
