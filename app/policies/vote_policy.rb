class VotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  def create?
    if record.user == user || record.participants.include?(user)
      return true
    else
     return false
    end
  end
end
