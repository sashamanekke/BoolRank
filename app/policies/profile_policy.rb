class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  def show?
    if record.user == user
      return true
    end
  end
  def edit?
    if record.user == user
      return true
    end
  end
  def update?
    if record.user == user
      return true
    end
  end
end
