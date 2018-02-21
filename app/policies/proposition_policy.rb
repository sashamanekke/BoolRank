class PropositionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  def create?
    return true
  end
  def add_propositions?
    return true
  end
end
