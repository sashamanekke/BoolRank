class Vote < ApplicationRecord
  belongs_to :poll
  belongs_to :user
  belongs_to :accepted_proposition, :class_name => 'Proposition'
  belongs_to :rejected_proposition, :class_name => 'Proposition'

  #testing code -- can be deleted
  # def self.integerify_id(id)
  #   myAlphabetCode = [
  #   ["1", "1"],
  #   ["2", "2"],
  #   ["3", "3"],
  #   ["4", "4"],
  #   ["5", "5"],
  #   ["6", "6"],
  #   ["7", "7"],
  #   ["8", "8"],
  #   ["9", "9"],
  #   ["0", "0"],
  #   ["a", "11"],
  #   ["b", "12"]
  #   ]
  #   result = ""
  #   id.each_char do |i|
  #     myAlphabetCode.each do |pair|
  #       if (pair[0] == i)
  #         result += pair[1]
  #       end
  #     end
  #   end
  #   result
  # end
end
